APP_NAME=accessible-pdf
DOCKER_COMPOSE=docker-compose -p $(APP_NAME) -f ./docker/docker-compose.yml
DOCKERFILE=./docker/Dockerfile

IMAGE_TAG ?= latest
REGISTRY_URL ?= registry.com/app
FULL_IMAGE=$(REGISTRY_URL)/$(APP_NAME):$(IMAGE_TAG)

rebuild:
	$(DOCKER_COMPOSE) build --no-cache

up:
	$(DOCKER_COMPOSE) up -d

down:
	$(DOCKER_COMPOSE) down

restart:
	$(DOCKER_COMPOSE) down
	$(DOCKER_COMPOSE) up

logs:
	$(DOCKER_COMPOSE) logs -f

sh:
	$(DOCKER_COMPOSE) exec app /bin/sh

docker-build:
	docker buildx build --platform linux/amd64 --file $(DOCKERFILE) -t $(FULL_IMAGE) .

docker-push:
	docker push $(FULL_IMAGE)

helm-deploy:
	helm upgrade --install accessible-pdf ./helm --namespace $(APP_NAME) --create-namespace \
		--set image.repository=$(REGISTRY_URL)/$(APP_NAME) \
		--set image.tag=$(IMAGE_TAG)

helm-delete:
	helm uninstall accessible-pdf

docker-publish: docker-build docker-push

deploy: docker-publish helm-deploy