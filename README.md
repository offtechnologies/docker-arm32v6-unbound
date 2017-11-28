# Raspberry Pi 1 Unbound 1.6.7 Docker Image With Alpine Linux

[![Build Status](https://travis-ci.org/offtechnologies/docker-arm32v6-unbound.svg?branch=master)](travis-ci.org/offtechnologies/docker-arm32v6-unbound)
[![This image on DockerHub](https://img.shields.io/docker/pulls/offtechnologies/docker-arm32v6-unbound.svg)](https://hub.docker.com/r/offtechnologies/docker-arm32v6-unbound/)
[![](https://images.microbadger.com/badges/version/offtechnologies/docker-arm32v6-unbound.svg)](https://microbadger.com/images/offtechnologies/docker-arm32v6-unbound "Get your own version badge on microbadger.com")
[![](https://images.microbadger.com/badges/image/offtechnologies/docker-arm32v6-unbound.svg)](https://microbadger.com/images/offtechnologies/docker-arm32v6-unbound "Get your own image badge on microbadger.com")


[offtechurl]: https://offtechnologies.gthub.io

[![offtechnologies](https://raw.githubusercontent.com/offtechnologies/offtechnologies.github.io/master/logo.png)][offtechurl]


docker run -d --name unbound -p 53:53 -p 53:53/udp --cap-add=NET_ADMIN --cap-add=NET_BIND_SERVICE --network host offtechnologies/docker-arm32v6-unbound:1.6.7


docker run -d --name unbound -p 53:53 -p 53:53/udp --dns="127.0.0.1" offtechnologies/docker-arm32v6-unbound:1.6.7


Raspberry Pi 1 compatible Docker base image with Alpine Linux and Unbound.

## Credits


## 0.0.0 - 2017-11-28
* work in progress
* Custom base image: Alpine Linux arm32v6 ver 3.6 with qemu-arm-static
* Tested on Raspberry Pi 1 Model B Rev 2 with Arch Linux 4.9.58-1 and Docker v17.11.0-ce
