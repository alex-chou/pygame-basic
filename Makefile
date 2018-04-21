.PHONY: up down clean

APP_NAME=pygame-basic
MOUNT_POINT=/usr/src/app

up: docker-build docker-run # Build and run container

down: docker-stop # Stop container

clean: down docker-rm-containers docker-rm-images # Clean up running docker dangling containers / images

docker-build: # Build the container
	docker build -t $(APP_NAME) .

docker-run: # Run the container (detached)
	docker run -it --rm --name $(APP_NAME) -v $$PWD:$(MOUNT_POINT) -d $(APP_NAME)

docker-bash: # Run bash on the running container
	docker exec -it $(APP_NAME) bash

docker-stop: # Stop the running container
	docker stop -t 0 $(APP_NAME) || true

docker-rm-containers: # Remove dangling containers
	docker container prune

docker-rm-images: # Remove dangling images
	docker image prune
