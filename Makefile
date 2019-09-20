THIS     := $(realpath $(lastword $(MAKEFILE_LIST)))
THIS_DIR := $(shell dirname $(THIS))

DOCKER     ?= docker
IMAGE_REPO ?= jarrednicholls/rke-cluster-tools
IMAGE_TAG  ?= v2

.PHONY: all build

all: build

build:
	$(DOCKER) build \
		-f $(THIS_DIR)/Dockerfile \
		-t $(IMAGE_REPO):$(IMAGE_TAG) \
		-t $(IMAGE_REPO) \
		$(THIS_DIR)

push:
	$(DOCKER) push $(IMAGE_REPO):$(IMAGE_TAG) \
	&& $(DOCKER) push $(IMAGE_REPO)
