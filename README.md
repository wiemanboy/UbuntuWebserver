# ubuntu-webserver

This repo describes and helps build my webserver.

## Requirements

- ubuntu
- docker
- static ip
- port forwarded port 80
- port forwarded port 443
- domain name specified in the compose file
- DNS records pointing to the static ip

## Building

This repo includes a [docker compose](docker-compose.yml) that can be used
to start up the different services in swarm mode,
to do so run:

```bash
sudo docker compose -f registry-compose.yml up -d
```
This will initialize a local registry
that can be used to store the images that need to be built as this cannot be done in the swarm mode.

After the registry is up and running, build and push the images as needed:

```bash
sudo docker build -t localhost:5000/blobstore ./blobstore && sudo docker push localhost:5000/blobstore
```

Now that everything is set up, we can deploy the stack:
```bash
sudo docker stack deploy --compose-file docker-compose.yml server
```

