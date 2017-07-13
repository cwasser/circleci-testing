__DIR__ := $(dir $(realpath $(lastword $(MAKEFILE_LIST))))

include ../resources/make/functions.mk

help: ## Display this help
	@printf "$(FG_YELLOW)Usage:$(RESET)\n    make [flags] [target] [options]\n\n"
	@printf "$(FG_YELLOW)Flags:$(RESET)\n    See $(FG_GRAY)make --help$(RESET)\n\n"
	@printf "$(FG_YELLOW)Targets:$(RESET)\n"
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(__DIR__)/Makefile | sort -d | awk 'BEGIN {FS = ":.*?## "}; {printf "    $(FG_GREEN)%-$(HELP_PADDING)s$(RESET) %s\n", $$1, $$2}'
	@printf "\n$(FG_YELLOW)Options:$(RESET)\n"
	@printf "$(FG_GREEN)%-$(HELP_PADDING)s$(RESET) Set mode to 1 for verbose output $(FG_YELLOW)[default: 0]$(RESET)\n" "VERBOSE=<mode>"
	@printf "$(FG_GREEN)%-$(HELP_PADDING)s$(RESET) Set the tag for the $(FG_GREEN)web-server$(RESET) target's container $(FG_YELLOW)[default: latest]$(RESET)\n" "WEB_SERVER_TAG=<tag>"
	@printf "$(FG_GREEN)%-$(HELP_PADDING)s$(RESET) Set the tag for the $(FG_GREEN)web-server-debug(RESET) target's container $(FG_YELLOW)[default: latest]$(RESET)\n" "WEB_SERVER_DEBUG_TAG=<tag>"
	@printf "\n"
.PHONY: help

dockerfiles: ## Generate the docker files
	if command -v php >/dev/null;\
		then php bin/gen-dockerfiles;\
		else docker run -it --rm --name gen-dockerfiles \
			-v $(__DIR__)://src -w //src php:cli php bin/gen-dockerfiles;\
	fi

WEB_SERVER_TAG ?= latest
web-server: ## Build the production image
	[ -f Dockerfile.web-server ] || $(MAKE) dockerfiles
	$(call docker_build,$(WEB_SERVER_TAG))

WEB_SERVER_DEBUG_TAG ?= latest
web-server-debug: ## Build the debug image
	[ -f Dockerfile.web-server ] || $(MAKE) dockerfiles
	$(call docker_build,$(WEB_SERVER_DEBUG_TAG))
