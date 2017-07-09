__DIR__ := $(dir $(realpath $(lastword $(MAKEFILE_LIST))))

include resources/make/functions.mk

help: ## Display this help
	@printf "$(FG_YELLOW)Usage:$(RESET)\n    make [flags] [target] [options]\n\n"
	@printf "$(FG_YELLOW)Flags:$(RESET)\n    See $(FG_GRAY)make --help$(RESET)\n\n"
	@printf "$(FG_YELLOW)Targets:$(RESET)\n"
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(__DIR__)/Makefile | sort -d | awk 'BEGIN {FS = ":.*?## "}; {printf "    $(FG_GREEN)%-$(HELP_PADDING)s$(RESET) %s\n", $$1, $$2}'
	@printf "\n$(FG_YELLOW)Options:$(RESET)\n"
	@printf "$(FG_GREEN)%-$(HELP_PADDING)s$(RESET) Set mode to 1 for verbose output $(FG_YELLOW)[default: 0]$(RESET)\n" "VERBOSE=<mode>"
	@printf "$(FG_GREEN)%-$(HELP_PADDING)s$(RESET) Set the tag for the $(FG_GREEN)web-server$(RESET) target's container $(FG_YELLOW)[default: latest]$(RESET)\n" "WEB_SERVER_TAG=<tag>"
	@printf "$(FG_GREEN)%-$(HELP_PADDING)s$(RESET) Set the tag for the $(FG_GREEN)web-service$(RESET) target's container $(FG_YELLOW)[default: latest]$(RESET)\n" "WEB_SERVICE_TAG=<tag>"
	@printf "\n$(FG_YELLOW)Pro-tip:$(RESET) use $(FG_GRAY)make -j \`nproc\` [target]$(RESET) for parallel execution.\n\n"
.PHONY: help

docker-clean: ## Cleanup unused docker resources
	docker system prune --force
.PHONY: docker-clean

docker-cleaner: ## Cleanup all docker resources
	docker system prune --all --force
.PHONY: docker-cleaner

web-server: ## Build the Web Server container
	$(MAKE) -C $@ $@
.PHONY: web-server

web-service: ## Build the Web Service container
	$(MAKE) -C $@ $@
.PHONY: web-service
