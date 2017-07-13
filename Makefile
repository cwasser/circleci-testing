__DIR__ := $(dir $(realpath $(lastword $(MAKEFILE_LIST))))

include resources/make/functions.mk

help: ## Display this help
	@printf "$(FG_YELLOW)Usage:$(RESET)\n    make [flags] [target] [options]\n\n"
	@printf "$(FG_YELLOW)Flags:$(RESET)\n    See $(FG_GRAY)make --help$(RESET)\n\n"
	@printf "$(FG_YELLOW)Targets:$(RESET)\n"
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(__DIR__)/Makefile | sort -d | awk 'BEGIN {FS = ":.*?## "}; {printf "    $(FG_GREEN)%-$(HELP_PADDING)s$(RESET) %s\n", $$1, $$2}'
	@printf "\n$(FG_YELLOW)Options:$(RESET)\n"
	@printf "$(FG_GREEN)%-$(HELP_PADDING)s$(RESET) Set mode to 1 for verbose output $(FG_YELLOW)[default: 0]$(RESET)\n" "VERBOSE=<mode>"
	@printf "$(FG_GREEN)%-$(HELP_PADDING)s$(RESET) Build the image if it is missing, instead of pulling it $(FG_YELLOW)[default: false]$(RESET)\n" "REBUILD=<bool>"
	@printf "$(FG_GREEN)%-$(HELP_PADDING)s$(RESET) Set the tag for the $(FG_GREEN)web-server$(RESET) target's container $(FG_YELLOW)[default: latest]$(RESET)\n" "WEB_SERVER_TAG=<tag>"
	@printf "$(FG_GREEN)%-$(HELP_PADDING)s$(RESET) Set the tag for the $(FG_GREEN)web-service$(RESET) target's container $(FG_YELLOW)[default: latest]$(RESET)\n" "WEB_SERVICE_TAG=<tag>"
	@printf "\n$(FG_YELLOW)Pro-tip:$(RESET) use $(FG_GRAY)make -j \`nproc\` [target]$(RESET) for parallel execution.\n\n"
.PHONY: help

REBUILD ?= false
dev-server: ## Pull and start development server (see REBUILD flag)
	if [ $(REBUILD) != true ]
		then docker-compose --file config/docker/compose-dev.yml pull --ignore-pull-failures --parallel
		else [ -f web-server/Dockerfile.web-server ] || $(MAKE) -C web-server dockerfiles
	fi
	docker-compose --file config/docker/compose-dev.yml up --abort-on-container-exit --no-recreate --remove-orphans
.PHONY: dev-server

docker-clean: ## Cleanup unused docker resources
	docker system prune --force
.PHONY: docker-clean

docker-cleaner: ## Cleanup all docker resources
	docker system prune --all --force
.PHONY: docker-cleaner
