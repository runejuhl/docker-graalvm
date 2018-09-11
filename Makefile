VERSION ?= $(shell git describe --tags --abbrev=0)

export VERSION

.PHONY: docker
docker: Dockerfile
	docker build --build-arg GRAALVM_VERSION=$(VERSION) -t $(USER)/graalvm:$(VERSION) .
