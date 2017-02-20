#!/bin/env ruby

unless File.exist?('./occupy.rb')
  puts "need the occupy.rb library"
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

  # install vim-plug
  vimplug_link = 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  unless File.exist?("#{init.dotdir}/vim/autoload/plug.vim")
    vim.shell("curl -fLo \"#{init.dotdir}/vim/autoload/plug.vim\" --create-dirs \"#{vimplug_link}\"")
  end

  # update vim-plug
  vim.shell('$(which nvim) +PlugUpdate +:q! +:q! &>/dev/null')

  init.register(vim)
end

InitModule.new('zsh') do |zsh|
  zsh.links = [
    InitLink.new(init, 'zsh/zshrc', init.dotdir + '/zsh/.zshrc'),
    InitLink.new(init, 'zsh/modules/fasd.rc', Dir.home + '/.fasdrc'),
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
  unless ENV.key?('GOPATH')
    porc.report_error 'No Go environment found! Set GOPATH'
  end

  porc.shell('go get -u github.com/robertgzr/porcelain')
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

USAGE = %(Usage: ./init.rb [run | dry | test]
run\t install everything
dry\t show what it is going to install
test\t test the system
)
case ARGV[0]
when 'dry'
  init.dry_run
when 'run'
  init.run
when 'test'
  init.test
else
  puts USAGE
end
