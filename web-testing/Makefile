__DIR__ := $(dir $(realpath $(lastword $(MAKEFILE_LIST))))
include ../resources/make/bootstrap.mk

composer = $(call composer_ex,$@)
define composer_ex =
	echo "docker run \
		-it --rm --name composer \
		-v $(__DIR__)..://src \
		-v $(__DIR__)../target/cache/composer://root/.composer \
		--entrypoint composer \
		-w //src/web-testing \
		fleshgrinder/web-service-dev:latest \
		$(1)"
endef

clean: ## Cleanup artifacts
	rm -fr target/
.PHONY: clean

cleaner: clean ## Cleanup artifacts and dependencies
	rm -fr vendor/
.PHONY: cleaner

clear-cache: ## Clear caches
	$(call composer)
.PHONY: clear-cache

install: ## Install dependencies
	echo "call composer install"
	$(call composer_ex,install --no-suggest)
	echo "composer install done"

test: install ## Run all tests
	docker-compose -f ../config/docker/compose-dev.yml -f config/docker/compose-test.yml up --abort-on-container-exit --remove-orphans
.PHONY: test

update: composer.json ## Update dependencies
	$(call composer)
.PHONY: update
