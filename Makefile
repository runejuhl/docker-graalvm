VERSION ?= 1.0.0-rc10

export VERSION

.PHONY: docker
docker: Dockerfile
	docker build --build-arg GRAALVM_VERSION=$(VERSION) -t $(USER)/graalvm:$(VERSION) .

.PHONY: docker/push
docker/push:
	docker push $(USER)/graalvm:$(VERSION)
