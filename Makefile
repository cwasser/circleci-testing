HELP_PADDING := 25
help: ## Display this help
	@printf "$(FG_YELLOW)Usage:$(RESET)\n    make [flags] [target] [options]\n\n"
	@printf "$(FG_YELLOW)Flags:$(RESET)\n    See $(FG_GRAY)make --help$(RESET)\n\n"
	@printf "$(FG_YELLOW)Targets:$(RESET)\n"
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort -d | awk 'BEGIN {FS = ":.*?## "}; {printf "    $(FG_GREEN)%-$(HELP_PADDING)s$(RESET) %s\n", $$1, $$2}'
	@printf "\n$(FG_YELLOW)Options:$(RESET)\n    $(FG_GREEN)%-$(HELP_PADDING)s$(RESET) Set mode to 1 for verbose output $(FG_YELLOW)[default: 0]$(RESET)\n\n" "VERBOSE=<mode>"
	@printf "$(FG_YELLOW)Pro-tip:$(RESET) use $(FG_GRAY)make -j \`nproc\` [target]$(RESET) for parallel execution.\n\n"
.PHONY: help

containers: server service ## Build all containers
.PHONY: containers

docker-clean: ## Cleanup unused docker resources
	docker system prune --force
.PHONY: docker-clean

docker-cleaner: ## Cleanup all docker resources
	docker system prune --all --force
.PHONY: docker-cleaner

server: ## Build the Web Server container
	cd $(__DIR__)web-server
	docker build --force-rm --pull -t fleshgrinder/web-server:latest .
.PHONY: web-server-container

service: ## Build the Web Service container
	cd $(__DIR__)web-service
	docker build --force-rm --pull -t fleshgrinder/web-service:latest .
.PHONY: web-service-container

# ------------------------------------------------------------------------------ Config

SHELL       = /bin/sh
__DIR__    := $(dir $(realpath $(lastword $(MAKEFILE_LIST))))

BOLD       := \033[1m
RESET      := \033[0m

FG_BLACK   := \033[30m
FG_RED     := \033[31m
FG_GRAY    := $(BOLD)$(FG_WHITE)
FG_GREEN   := \033[32m
FG_YELLOW  := \033[33m
FG_BLUE    := \033[34m
FG_MAGENTA := \033[35m
FG_CYAN    := \033[36m
FG_WHITE   := \033[37m

BG_BLACK   := \033[40m
BG_RED     := \033[41m
BG_GREEN   := \033[42m
BG_YELLOW  := \033[43m
BG_BLUE    := \033[44m
BG_MAGENTA := \033[45m
BG_CYAN    := \033[46m
BG_WHITE   := \033[47m

ifndef VERBOSE
.SILENT:
endif

.ONESHELL:
.SUFFIXES:
