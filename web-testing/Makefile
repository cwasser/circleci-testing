__DIR__ := $(dir $(realpath $(lastword $(MAKEFILE_LIST))))
include ../resources/make/bootstrap.mk

COMPOSER_EX = $(call composer,web-service-test,$(1))
COMPOSER    = $(call COMPOSER_EX,$@)

clean: ## Cleanup artifacts
	rm -fr target/
.PHONY: clean

cleaner: clean ## Cleanup artifacts and dependencies
	rm -fr vendor/
.PHONY: cleaner

clear-cache: ## Clear caches
	$(call COMPOSER)
.PHONY: clear-cache

install: composer.json ## Install dependencies
composer.json: composer.lock
composer.lock: vendor/autoload.php
vendor/autoload.php:
	$(call COMPOSER_EX,install --no-suggest)
	touch $@

test: install ## Run all tests
	$(call COMPOSER)
.PHONY: test

update: composer.json ## Update dependencies
	$(call COMPOSER)
.PHONY: update
