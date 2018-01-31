DBG_MAKEFILE ?=
ifeq ($(DBG_MAKEFILE),1)
	$(warning ***** starting Makefile for goal(s) "$(MAKECMDGOALS)")
	$(warning ***** $(shell date))
else
	MAKEFLAGS += -s
endif

# Metadata for driving the build lives here.
META_DIR := .make
SHELL := /usr/bin/env bash

default: help

help:

	@echo "---> Help menu:"
	@echo ""
	@echo "Help output:"
	@echo "make help"
	@echo ""
	@echo "Install pre-commit hooks"
	@echo "make install-hooks"
	@echo ""
	@echo "Clean the repo of pre-commit hooks"
	@echo "make clean-hooks"
	@echo ""
	@echo "Run pre-commit hooks locally"
	@echo "make run-hooks"
	@echo ""
	@echo "Build container"
	@echo "make build"
	@echo ""
	@echo "Run container"
	@echo "make run"
	@echo ""

NAME := slack-pom
REGISTRY := quay.io
BUILD_DATE := $(shell date -u +%Y-%m-%dT%H:%M:%SZ)
GIT_SHA := $(shell git log -1 --format=%h)
GIT_TAG := $(shell bash -c 'TAG=$$(git tag | tail -n1); echo "$${TAG:none}"')
GIT_MESSAGE := $(shell git -c log.showSignature=false log --max-count=1 --pretty=format:"%H")
CONTAINER_NAME := $(REGISTRY)/$(NAME):$(GIT_SHA)

export NAME REGISTRY BUILD_DATE GIT_SHA GIT_TAG GIT_MESSAGE CONTAINER_NAME

.PHONY: all help build run install-hooks clean-hooks run-hooks

all: build test

build:
	docker build -t "$(CONTAINER_NAME)" \
		--rm=true \
		--file=Dockerfile \
		.

clean:
	docker rmi $(CONTAINER_NAME)

run: build
	docker run --rm -e SLACK_API_TOKEN=${SLACK_API_TOKEN} -e SLACK_USER=${SLACK_USER} -it $(CONTAINER_NAME)

install-hooks:
	pip install -r requirements.txt
	pip install --upgrade pre-commit
	pre-commit install --install-hooks
	pre-commit autoupdate

clean-hooks:
	pre-commit clean
	pre-commit uninstall

run-hooks: install-hooks
	pre-commit run --all-files
