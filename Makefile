USER = rednut
NAME = ubuntu
REPO = $(USER)/$(NAME)
VERSION = $(shell touch VERSION && cat VERSION)

CONTAINER = "ubuntu"


build: version_inc build_image tag_latest


version_inc:
	@VERSION inc

tag_latest:
	@docker tag $(REPO):$(VERSION) $(REPO):latest


build_image:
	@docker build -t="$(REPO):$(VERSION)" --rm .


