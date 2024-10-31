.PHONY: setup setup\:network setup\:images build\:registry build\:swarm deploy update update\:all

setup: build\:registry setup\:images build\:swarm setup\:network deploy

setup\:dependencies:
	sudo apt-get update && sudo apt-get install -y \
		apache2-utils \

setup\:images:
	for dir in ./setup/*; do \
	  if [ -d "$$dir" ]; then \
	    image_name=$$(basename "$$dir"); \
	    sudo docker build -t localhost:5000/$$image_name $$dir && sudo docker push localhost:5000/$$image_name; \
	  fi; \
	done

setup\:network:
	sudo docker network create --driver=overlay --attachable reverse_proxy_network

build\:registry:
	sudo docker compose -f registry-compose.yml up -d

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
