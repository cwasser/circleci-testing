SHELL         = /bin/sh
__CWD__      := $(shell cd $(__DIR__))

HELP_PADDING := 25

BOLD         := \033[1m
RESET        := \033[0m

FG_BLACK     := \033[30m
FG_RED       := \033[31m
FG_GRAY      := $(BOLD)$(FG_WHITE)
FG_GREEN     := \033[32m
FG_YELLOW    := \033[33m
FG_BLUE      := \033[34m
FG_MAGENTA   := \033[35m
FG_CYAN      := \033[36m
FG_WHITE     := \033[37m

BG_BLACK     := \033[40m
BG_RED       := \033[41m
BG_GREEN     := \033[42m
BG_YELLOW    := \033[43m
BG_BLUE      := \033[44m
BG_MAGENTA   := \033[45m
BG_CYAN      := \033[46m
BG_WHITE     := \033[47m

ifndef VERBOSE
.SILENT:
endif

.ONESHELL:
.SUFFIXES:

define docker_build =
	docker build \
		--cache-from=$@ \
		--force-rm \
		--pull \
		--file Dockerfile.$@ \
		--tag fleshgrinder/$@:$(1) \
		.
endef

# Extra leading slashes are for Windows compatibility!
# Cache is stored in root for sharing with other PHP based containers!
define composer =
	docker run \
		-v $(__DIR__)://usr/local/src \
		-v $(__DIR__)../target/cache/composer://root/.composer \
		--entrypoint composer \
		--rm \
		-ti \
		fleshgrinder/$(1) \
		$(2)
endef
