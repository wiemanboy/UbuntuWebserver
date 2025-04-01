.PHONY: setup setup\:network setup\:images build\:registry build\:swarm deploy update update\:all

setup: build\:swarm setup\:network deploy

setup\:dependencies:
	sudo apt-get update && sudo apt-get install -y \
		apache2-utils \

setup\:network:
	sudo docker network create --driver=overlay --attachable reverse_proxy_network

build\:swarm:
	sudo docker swarm init

deploy:
	 for file in swarm-compose*.yml; do \
	   if [ -f "$$file" ]; then \
		 files="$$files -c $$file"; \
	   fi; \
	 done; \
	 sudo docker stack deploy $$files server

update:
	sudo docker service update --image $(image):$(version) $(service)

update\:all: deploy
