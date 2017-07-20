__DIR__ := $(dir $(realpath $(lastword $(MAKEFILE_LIST))))
include ../resources/make/bootstrap.mk

composer = $(call composer_ex,$@)
define composer_ex =
	docker run \
		-it --rm --name composer \
		-v $(__DIR__)..://src \
		-v $(__DIR__)../target/cache/composer://root/.composer \
		--entrypoint composer \
		-w //src/web-service \
		fleshgrinder/web-service-dev:latest \
		$(1)
endef

clean: ## Cleanup artifacts
	rm -fr Dockerfile.web-service-*
.PHONY: clean

cleaner: clean ## Cleanup artifacts and dependencies
	rm -fr vendor/
.PHONY: cleaner

clear-cache: ## Clear caches
	$(call composer)
.PHONY: clear-cache

install: composer.json ## Install dependencies
composer.json: composer.lock
composer.lock: vendor/autoload.php
vendor/autoload.php:
	$(call composer_ex,install --no-suggest)
	touch $@

test: install ## Run all tests
	$(call composer)
.PHONY: test

update: composer.json ## Update dependencies
	$(call composer)
.PHONY: update

dockerfiles: ## Generate the docker files
	docker run -it --rm --name gen-dockerfiles -v $(__DIR__)..://src -w //src/web-service php:cli php bin/gen-dockerfiles

prod-image: ## Build the production image
	$(MAKE) image ENV=prod
.PHONY: prod-image

dev-image: ## Build the development image
	$(MAKE) image ENV=dev
.PHONY: dev-image

image:
	[ -f Dockerfile.web-serice-$(ENV) ] || $(MAKE) dockerfiles
	$(call docker_build,web-service-$(ENV))
.PHONY: image
