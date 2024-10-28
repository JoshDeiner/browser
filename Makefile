# Variables
IMAGE_NAME = searxng-custom
CONTAINER_NAME = searxng-instance
PORT = 8080
VERSION = 1.0.0
NETWORK= search_network

# Targets
build:
	docker build -t $(IMAGE_NAME):$(VERSION) .

run-net:
	docker run --network $(NETWORK) --rm -d -p $(PORT):8080 --name $(CONTAINER_NAME) $(IMAGE_NAME):$(VERSION)

run:
	docker run --rm -d -p $(PORT):8080 --name $(CONTAINER_NAME) $(IMAGE_NAME):$(VERSION)

tag-latest:
	docker tag $(IMAGE_NAME):$(VERSION) $(IMAGE_NAME):latest



network:
	docker network ls | grep -q $(NETWORK) || docker network create $(NETWORK)

stop:
	docker stop $(CONTAINER_NAME)

remove:
	docker rm $(CONTAINER_NAME)

logs:
	docker logs -f $(CONTAINER_NAME)

exec:
	docker exec -it $(CONTAINER_NAME) /bin/sh

# Cleanup
clean:
	docker stop $(CONTAINER_NAME) || true
	docker rm $(CONTAINER_NAME) || true
	docker rmi $(IMAGE_NAME) || true
	docker network rm $(NETWORK) || true
