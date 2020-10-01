NAME   := ${REGISTRY_HOST}/${REGISTRY_REPO}/vic-blog
TAG    := $(shell git describe --tags)
IMG    := $(NAME):$(TAG)
 
build:
	@docker build -t ${IMG} .

push:
	@docker push ${IMG}

login:
	@docker login -u ${DOCKER_USERNAME} ${REGISTRY_HOST} -p ${DOCKER_PASSWORD}

deploy:
	@ssh ${ENV_USER}@${ENV_HOST} -p ${ENV_PASSWORD}
	@ssh 

help: ## Display this help screen
	@grep -h -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'