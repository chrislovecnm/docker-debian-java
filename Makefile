# Copyright 2017 Vorstella

TAG?=8
GROUP_ID?=vorstella
PROJECT_ID?=java
REPO?=${GROUP_ID}/${PROJECT_ID}
VCS=https://github.com/vorstella/docker-java

JAVA_VERSION?=8u131-b11-2ubuntu1.16.04.3

all: build

docker:
	docker build --compress --squash --build-arg "JAVA_VERSION=${JAVA_VERSION}" -t ${REPO}:${TAG} .

docker-dev:
	docker build --pull --build-arg "JAVA_VERSION=${JAVA_VERSION} DEV_CONTAINER=1" -t ${REPO}:${TAG}-dev .

docker-cached:
	docker build --compress --squash --build-arg "JAVA_VERSION=${JAVA_VERSION}" -t ${REPO}:${TAG} .

build: docker

build-dev: docker-dev

build-cached: docker-cached

push: build
	docker push ${REPO}:${TAG}

run: build-cached
	docker run -i -t --rm --net=host \
	${REPO}:${TAG}

shell: build-cached
	docker run -i -t --rm --net=host \
	${REPO}:${TAG} \
	/bin/bash

push-dev: build-dev
	docker push ${REPO}:${TAG}-dev

push-all: build build-dev push push-dev

.PHONY: all build push docker docker-dev build-dev push push-all
