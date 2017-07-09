__DIR__ := $(dir $(realpath $(lastword $(MAKEFILE_LIST))))

include ../resources/make/functions.mk

COMPOSER_IMAGE := web-service-test

help: ## Display this help
	@printf "$(FG_YELLOW)Usage:$(RESET)\n    make [flags] [target] [options]\n\n"
	@printf "$(FG_YELLOW)Flags:$(RESET)\n    See $(FG_GRAY)make --help$(RESET)\n\n"
	@printf "$(FG_YELLOW)Targets:$(RESET)\n"
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort -d | awk 'BEGIN {FS = ":.*?## "}; {printf "    $(FG_GREEN)%-$(HELP_PADDING)s$(RESET) %s\n", $$1, $$2}'
	@printf "\n$(FG_YELLOW)Options:$(RESET)\n"
	@printf "$(FG_GREEN)%-$(HELP_PADDING)s$(RESET) Set mode to 1 for verbose output $(FG_YELLOW)[default: 0]$(RESET)\n" "VERBOSE=<mode>"
	@printf "$(FG_GREEN)%-$(HELP_PADDING)s$(RESET) Set the tag for the $(FG_GREEN)prod-container$(RESET) target's container $(FG_YELLOW)[default: latest]$(RESET)\n" "WEB_SERVICE_TAG=<tag>"
	@printf "$(FG_GREEN)%-$(HELP_PADDING)s$(RESET) Set the tag for the $(FG_GREEN)test-container$(RESET) target's container $(FG_YELLOW)[default: latest]$(RESET)\n" "WEB_SERVICE_TEST_TAG=<tag>"
	@printf "\n$(FG_YELLOW)Pro-tip:$(RESET) use $(FG_GRAY)make -j \`nproc\` [target]$(RESET) for parallel execution.\n\n"
.PHONY: help

clean: ## Cleanup build artifacts
	rm -fr target/
.PHONY: clean

cleaner: clean ## Cleanup build artifacts and dependencies
	rm -fr vendor/
.PHONY: cleaner

install: composer.json ## Install dependencies
composer.json: composer.lock
composer.lock: vendor/autoload.php
vendor/autoload.php:
	$(call composer,$(COMPOSER_IMAGE),install --no-suggest)
	touch $@

test: install ## Run all tests
	$(call composer,$(COMPOSER_IMAGE),$@ --no-suggest)
.PHONY: test

update: composer.json ## Update dependencies
	$(call composer,$(COMPOSER_IMAGE),$@)
.PHONY: update

WEB_SERVICE_TAG ?= latest
web-service: Dockerfile.web-service ## Build the production container
	$(call docker_build,$(WEB_SERVICE_TAG))
	touch $<

WEB_SERVICE_TEST_TAG ?= latest
web-service-test: Dockerfile.web-service-test ## Build the test container
	$(call docker_build,$(WEB_SERVICE_TEST_TAG))
	touch $<
