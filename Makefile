__DIR__ := $(dir $(realpath $(lastword $(MAKEFILE_LIST))))
include resources/make/bootstrap.mk

ENV ?= dev

clean: ## Clean all artifacts
	$(MAKE) -C web-server clean
	$(MAKE) -C web-service clean
	$(MAKE) -C web-testing clean
.PHONY: clean

cleaner: ## Clean all artifacts and dependencies
	$(MAKE) -C web-service cleaner
	$(MAKE) -C web-testing cleaner
.PHONY: cleaner

docker-clean: ## Cleanup unused docker resources
	docker system prune --force
.PHONY: docker-clean

docker-cleaner: ## Cleanup all docker resources
	docker system prune --all --force
.PHONY: docker-cleaner

dockerfiles: ## Generate all docker files
	$(MAKE) -C web-server dockerfiles
	$(MAKE) -C web-service dockerfiles
.PHONY: dockerfiles

dev-server: ## Start development server
	$(MAKE) run ENV=dev
.PHONY: dev-server

prod-server: ## Start production server
	$(MAKE) run ENV=prod
.PHONY: server

install: ## Installs all dependencies
	$(MAKE) -C web-service install
	$(MAKE) -C web-testing install
.PHONY: install

run:
	docker-compose --file config/docker/compose-$(ENV).yml pull --ignore-pull-failures --parallel
	[ -f web-server/Dockerfile.web-server-$(ENV) ] || $(MAKE) -C web-server dockerfiles
	[ -f web-service/Dockerfile.web-service-$(ENV) ] || $(MAKE) -C web-service dockerfiles
	docker-compose --file config/docker/compose-$(ENV).yml up --abort-on-container-exit --remove-orphans
.PHONY: run

test: ## Execute all tests
	$(MAKE) -C web-service test
	$(MAKE) -C web-testing test
.PHONY: test

prod-test: ## Execute all tests with prod-environment
	$(MAKE) -C web-service prod-test
	$(MAKE) -C web-testing prod-test
.PHONY: test
