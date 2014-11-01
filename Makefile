USER := rednut
NAME = ubuntu
REPO := $(USER)/$(NAME)
VERSION = $(shell touch VERSION && cat VERSION)
VERSION ?= 0

OLD := $(VERSION)
CONTAINER := "ubuntu"

.PHONY: all build version_inc build_image tag_latest test tag_latest release ssh

build: version_inc build_image tag_latest


version_inc:
	@VERSION inc


tag_latest:
	@echo "tagging version $(REPO):$(VERSION) to $(REPO):latest"
	@docker tag $(REPO):$(VERSION) $(REPO):latest


build_image:
	@echo "building $(REPO):$(VERSION)"
	@docker build -t="$(REPO):$(VERSION)" --rm .


