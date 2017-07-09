__DIR__ := $(dir $(realpath $(lastword $(MAKEFILE_LIST))))

include ../resources/make/functions.mk

COMPOSER_EX = $(call composer,web-service-test,$(1))
COMPOSER    = $(call COMPOSER_EX,$@)

help: ## Display this help
	@printf "$(FG_YELLOW)Usage:$(RESET)\n    make [flags] [target] [options]\n\n"
	@printf "$(FG_YELLOW)Flags:$(RESET)\n    See $(FG_GRAY)make --help$(RESET)\n\n"
	@printf "$(FG_YELLOW)Targets:$(RESET)\n"
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(__DIR__)/Makefile | sort -d | awk 'BEGIN {FS = ":.*?## "}; {printf "    $(FG_GREEN)%-$(HELP_PADDING)s$(RESET) %s\n", $$1, $$2}'
	@printf "\n$(FG_YELLOW)Options:$(RESET)\n"
	@printf "$(FG_GREEN)%-$(HELP_PADDING)s$(RESET) Set mode to 1 for verbose output $(FG_YELLOW)[default: 0]$(RESET)\n" "VERBOSE=<mode>"
	@printf "$(FG_GREEN)%-$(HELP_PADDING)s$(RESET) Set the tag for the $(FG_GREEN)web-service$(RESET) target's container $(FG_YELLOW)[default: latest]$(RESET)\n" "WEB_SERVICE_TAG=<tag>"
	@printf "$(FG_GREEN)%-$(HELP_PADDING)s$(RESET) Set the tag for the $(FG_GREEN)web-service-test$(RESET) target's container $(FG_YELLOW)[default: latest]$(RESET)\n" "WEB_SERVICE_TEST_TAG=<tag>"
	@printf "\n"
.PHONY: help

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

WEB_SERVICE_TAG ?= latest
web-service: Dockerfile.web-service ## Build the production image
	$(call docker_build,$(WEB_SERVICE_TAG))
	touch $<

WEB_SERVICE_TEST_TAG ?= latest
web-service-test: Dockerfile.web-service-test ## Build the test image
	$(call docker_build,$(WEB_SERVICE_TEST_TAG))
	touch $<
