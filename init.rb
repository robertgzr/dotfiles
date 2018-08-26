#!/bin/env ruby

unless File.exist?('./occupy.rb')
  puts 'need the occupy.rb library'
  exit(1)
  # get occupy gem
end

require './occupy.rb'

unless ARGV[0] != ''
  puts USAGE
  exit(1)
end

# InitFramework.new takes 2 arguments
# - you can change the dotdir location (default: ~/.dotfiles)
# - and the config dir location (default: ~/.config)
init = InitFramework.new

# START of COMPONENTS

InitModule.new('dotfiles') do |dot|
  dot.shell('git submodule update --init --recursive')

  init.register(dot)
end

InitModule.new('homebrew') do |brew|
  brew.shell("eval #{init.dotdir}/install/brew/install")
  brew.shell('brew update')
  brew.shell('brew upgrade')
  brew.shell('brew bundle')

  init.register(brew)
end

InitModule.new('git') do |git|
  git.links = [
    InitLink.new(init, 'git/gitconfig', Dir.home + '/.gitconfig'),
    InitLink.new(init, 'git/gitignore_global', Dir.home + '/.gitignore_global')
  ]

  git.shell('git config --global core.excludesfile $HOME/.gitignore_global')

  init.register(git)
end

InitModule.new('vim') do |vim|
  vim.needs_dir = [
    init.dotdir + '/vim/backups',
    init.dotdir + '/vim/swaps',
    init.dotdir + '/vim/undo',
    init.dotdir + '/vim/autoload/plug.vim'
  ]
  vim.links = [
    InitLink.new(init, 'vim', Dir.home + '/.vim'),
    InitLink.new(init, 'vim', init.configdir + '/nvim')
  ]

  # update vim-plug
  vim.shell('$(which nvim) +PlugUpdate +:qall')

  init.register(vim)
end

InitModule.new('ctags') do |tags|
  tag.links = [
    InitLink.new(init, 'ctags/ctags', Dir.home + '/.ctags')
  ]

  init.register(tags)
end

InitModule.new('zsh') do |zsh|
  zsh.links = [
    InitLink.new(init, 'zsh/zshrc', init.dotdir + '/zsh/.zshrc'),
    InitLink.new(init, 'zsh/zshenv', init.dotdir + '/.zshenv'),
    InitLink.new(init, 'zsh/zshenv', Dir.home + '/.zshenv')
  ]

  init.register(zsh)
end

InitModule.new('tmux') do |tmux|
  tmux.links = [
    InitLink.new(init, 'tmux/tmux.conf', Dir.home + '/.tmux.conf'),
    InitLink.new(init, 'tmux/colors.conf', Dir.home + '/.tmux.colors.conf')
  ]

  init.register(tmux)
end

InitModule.new('config') do |config|
  config.links = []

  apps = ['mpv', 'livestreamer', 'youtube-dl', 'bitbar']
  apps.each do |a|
    config.links << InitLink.new(init, a, init.configdir + '/' + a)
  end

  init.register(config)
end

InitModule.new('osx') do |osx|
  osx.shell("eval #{init.dotdir}/osx/defaults.sh")
  osx.shell("eval #{init.dotdir}/osx/dock.sh")

  init.register(osx)
end

InitModule.new('hammerspoon') do |hs|
  hs.links = [
    InitLink.new(init, 'hammerspoon', Dir.home + '/.hammerspoon')
  ]

  init.register(hs)
end

InitModule.new('porcelain') do |porc|
  porc.shell('curl -L https://github.com/robertgzr/porcelain/releases/download/v0.1.1/porcelain_linux_amd64.tar.gz | tar xz && mv -fv ./porcelain /usr/local/bin/porcelain')
  unless porc.shell('which porcelain')
    porc.report_warning "Couldn't find 'porcelain'!\nIs GOPATH/bin in your PATH?"
  end

  init.register(porc)
end

InitModule.new('karabiner') do |kara|
  karadir = Dir.home + '/Library/Application Support/Karabiner'
  if Dir.exist?(karadir)
    if File.exist?(karadir + 'private.xml')
      kara.links = [
        InitLink.new(init, 'osx/karabiner/private.xml', karadir)
      ]
    end
  else
    kara.report_warning 'Karabiner not installed?'
  end

  init.register(kara)
end

InitModule.new('sublimetext') do |subl|
  subl.shell("for v in #{Dir.home}/sublimetext/User/Projects/*; do b64 \"$v\" -D; done")
  subl.shell("cp \"#{init.dotdir}/sublimetext/User\" \"#{Dir.home}/Library/Application Support/Sublime Text 3/Packages/User\"")

  init.register(subl)
end

# END of COMPONENTS

USAGE = %(Usage: ./init.rb [run | dry | test] <module>
run\t install everything
dry\t show what it is going to install
test\t test the system
).freeze
case ARGV[0]
when 'dry'
  if ARGV[1]
    init.dry_run(ARGV[1])
  else
    init.dry_run
  end
when 'run'
  if ARGV[1]
    init.run(ARGV[1])
  else
    init.run
  end
when 'test'
  if ARGV[1]
    init.test(ARGV[1])
  else
    init.test
  end
else
  puts USAGE
end
