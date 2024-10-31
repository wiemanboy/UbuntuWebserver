.PHONY: setup setup\:network setup\:images build\:registry build\:stack deploy update update\:all

setup: build\:registry setup\:images setup\:network build\:stack deploy

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

build\:stack:
	sudo docker stack init server

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
