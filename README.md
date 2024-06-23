# ubuntu-webserver

This repo describes and helps build my webserver.

## Requirements

- ubuntu 24+
- docker
- static ip
- port forwarded port 80

## Building

This repo includes a [docker compose](docker-compose.yml) that can be used to start up the different services, to do so run:

```bash
sudo docker compose up -d
```