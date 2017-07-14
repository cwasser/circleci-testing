__DIR__ := $(dir $(realpath $(lastword $(MAKEFILE_LIST))))
include ../resources/make/bootstrap.mk

dockerfiles: ## Generate the docker files
	if command -v php >/dev/null;\
		then php bin/gen-dockerfiles;\
		else docker run -it --rm --name gen-dockerfiles \
			-v $(__DIR__)://src -w //src php:cli php bin/gen-dockerfiles;\
	fi
.PHONY: dockerfiles

prod-image: ## Build the production image
	$(MAKE) image ENV=prod
.PHONY: prod-image

dev-image: ## Build the development image
	$(MAKE) image ENV=dev
.PHONY: dev-image

image:
	[ -f Dockerfile.web-server-$(ENV) ] || $(MAKE) dockerfiles
	$(call docker_build,web-server-$(ENV))
.PHONY: image
