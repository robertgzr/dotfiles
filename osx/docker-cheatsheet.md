# robertgzr's docker cheatsheet

### delete all docker containers
`docker ps -a` -- shows all containers
`docker rm <ID>`
`docker rm $(docker ps -aq)` -- delete all containers

!!!

**great alternative to docker-machine and virtualbox: [dlite](https://github.com/nlf/dlite)**
