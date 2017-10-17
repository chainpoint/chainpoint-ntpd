# First target in the Makefile is the default.
all: help

# without this 'source' won't work.
SHELL := /bin/bash

# Get the location of this makefile.
ROOT_DIR := $(dir $(abspath $(lastword $(MAKEFILE_LIST))))

# Specify the binary dependencies
REQUIRED_BINS := docker docker-compose
$(foreach bin,$(REQUIRED_BINS),\
    $(if $(shell command -v $(bin) 2> /dev/null),$(),$(error Please install `$(bin)` first!)))

.PHONY : help
help : Makefile
	@sed -n 's/^##//p' $<

## up              : Start ntpd
.PHONY : up
up:
	@docker-compose up -d

## down            : Shutdown ntpd
.PHONY : down
down:
	@docker-compose down

## restart         : Restart ntpd
.PHONY : restart
restart: down up

## build           : Build ntpd image
.PHONY : build
build:
	docker run --rm -w /usr/src/app -v ~/.docker:/root/.docker -v /var/run/docker.sock:/var/run/docker.sock -v "$(PWD)":/usr/src/app jizhilong/docker-make:latest docker-make --no-push
	docker container prune -f
	docker-compose build

## push            : Push ntpd image
.PHONY : push
push:
	docker run --rm -w /usr/src/app -v ~/.docker:/root/.docker -v /var/run/docker.sock:/var/run/docker.sock -v "$(PWD)":/usr/src/app jizhilong/docker-make:latest docker-make

## logs            : Tail ntpd logs
.PHONY : logs
logs:
	@docker-compose logs -f -t --tail=100

## ps              : View running processes
.PHONY : ps
ps:
	@docker-compose ps

## status          : Show docker ntpd status
.PHONY : status
status:
	@echo ''
	@docker exec -it chainpoint-ntpd ntpctl -s all
