# TODO: Linking files is not working the way it should!

# InitFramework wraps the components
class InitFramework
  attr_accessor :dotdir
  attr_accessor :configdir
  attr_accessor :modules

  def initialize(
    dot = Dir.home + '/.dotfiles',
    config = Dir.home + '/.config'
  )
    @modules = Hash.new
    @dotdir = dot
    @configdir = config
  end

  def register(new_module)
    raise 'Expected InitModule value' unless new_module.class == InitModule
    # @modules << new_module
    @modules[new_module.name] = new_module
  end

  def dry_run(m = 'all')
    puts "Installing #{m} (dry run)"
    if m == 'all'
      @modules.each_value do |m| m.install(true) end
    else
      @modules[m].install(true)
    end
  end

  def run(m = 'all')
    puts 'Installing', m
    if m == 'all'
      @modules.each_value(&:install)
    else
      @modules[m].install(false)
    end
  end

  def test(m = 'all')
    puts "Running tests for #{m}"
    if m == 'all'
      @modules.each_value(&:test)
    else
      @modules[m].test
    end
  end

end

# InitLink wraps InitFramework links
class InitLink
  attr_accessor :src
  attr_accessor :dst

  require 'fileutils'

  def initialize(framework, src, dst)
    @fw = framework
    @src = @fw.dotdir + '/' + src
    @dst = dst
  end

  def link
    FileUtils.ln_sf(src, dst)
  end
end

# InitModule is a component of the InitFramework
class InitModule
  attr_accessor :name
  attr_accessor :needs_dir
  attr_accessor :links
  attr_accessor :commands

  def initialize(name)
    raise 'Expected a name to be set' if name.empty?
    @name = name
    @commands = []

    yield(self) if block_given?
  end

  def shell(cmd)
    raise 'Expected a command' if cmd.nil?
    @commands << cmd
  end

  # Links the objects in to_home to the users HOME dir
  def link(dry = false)
    @links.each do |l|
      report "Linking: #{l.dst} -> #{l.src}"

      l.link unless dry
    end
  end

  def link_test
    @links.each do |l|
      check(l.dst)
    end unless @links.nil?
  end

  # Creates the directories in needs_dir
  def create_dirs(dry = false)
    @needs_dir.each do |dir|
      report "Creating: #{dir}"

      begin
        Dir.mkdir(dir) unless dry
      rescue SystemCallError
        report_warning 'directory exists!'
      end
    end
  end

  def create_dirs_test
    @needs_dir.each { |d| check(d) } unless @needs_dir.nil?
  end

  def run_shell_commands(dry = false)
    @commands.each do |cmd|
      report "Running: #{cmd}"
      Kernel.system(cmd) unless dry
    end
  end

  def run_shell_commands_test
    report_warning 'Can\' check if commands where successfull, sorry...'
  end

  def report(msg)
    puts "\e[37m#{@name}:\e[0m #{msg}"
  end

  # prints in green
  def report_success(msg)
    puts "\e[37m#{@name}:\e[0m \e[32m✔ #{msg}\e[0m"
  end

  # prints in red
  def report_error(msg)
    puts "\e[37m#{@name}:\e[0m \e[31m✖ #{msg}\e[0m"
  end

  # prints in yellow
  def report_warning(msg)
    puts "\e[37m#{@name}:\e[0m \e[33m! #{msg}\e[0m"
  end

  def check(f)
    File.exist?(f) ? report_success(f) : report_error("missing #{f}")
  end

  #
  # main functions that get called by the framework
  #
  def install(dry = false)
    create_dirs(dry) unless @needs_dir.nil?
    link(dry) unless @links.nil?
    run_shell_commands(dry) unless @commands.empty?
  end

  def test
    create_dirs_test unless @needs_dir.nil?
    link_test unless @links.nil?
    run_shell_commands_test unless @commands.empty?
  end
end
