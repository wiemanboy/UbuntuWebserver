# ubuntu-webserver

This repo describes and helps build my webserver.

## Requirements

- ubuntu (although other linux distributions should work)


- docker
- apache22-utils


- static ip
- port forwarded port 80
- port forwarded port 443
- domain name specified in the swarm files
- DNS records pointing to the static ip

## Building

This repo includes multiple swarm-compose files that can be used
to start up the different services in swarm mode.

### Environment

Before starting, make sure that all secrets defined in the swarm files are created.

```bash
printf "value" | sudo docker secret create secret_name -
```

The traefik password needs to be generated:
```bash
htpasswd -c -s userfile admin
sudo docker secret create traefik_users userfile 
```

### Auto setup

The server can be setup by running the following command:

```bash
make setup
```

### Manual setup
First, to set up the registry, this will be used to build local images like databases.

```bash
make build:registry
```

After the registry is set up, the images can be built and pushed:
```bash
make build:images
```

This will run all dockerfiles in the `setup` directory and push them to the registry.

Next, the network can be set up:

```bash
make setup:network
```

After the images are built and pushed, the stack can be initialized:
```bash
make build:stack
```

Now that everything is set up, we can deploy the stack:
```bash
make deploy
```

## Services

Services can be updated using the following command:

```bash
make update service=service_name image=image_name version=version
```