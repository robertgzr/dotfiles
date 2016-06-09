# Install Docker in OSX and don't use the Docker Toolchain

Cheatsheet for when I chnage machines

## Pre-Install

*install brew & brew-cask - this should done already*

```
brew update
brew install docker docker-machine docker-compose

# get virtualbox if it isn't installed already
```

## Create the Docker VM

create a new vm for boot2docker

`docker-machine create --driver=virtualbox default`

connect the docker client and engine to the new vm

`docker-machine env default`

## Use the Docker VM 

if the machine is setup from the robertgzr/dotfiles/init.sh there should be a shortcut in the ZSH aliases

`eval $(docker-machine env default)` or `dockerup`

return the IP address from your machine

`docker-machine ip default`

### footnote

* the name `default` is used here but this can be anything else as well
