# Copyright 2017 Vorstella

GROUP_ID?=vorstella
PROJECT_ID?=java
REPO?=${GROUP_ID}/${PROJECT_ID}
VCS=https://github.com/vorstella/docker-java

JAVA_VERSION?=8u131-b11-2ubuntu1.16.04.3
JAVA_VERSION_MAJOR?=8

VERSION_TAG?=${REPO}:$(JAVA_VERSION)
VERSION_TAG_MAJOR?=${REPO}:$(JAVA_VERSION_MAJOR)
TAGS?=-t ${VERSION_TAG} -t ${VERSION_TAG_MAJOR}

ifdef TRAVIS_COMMIT
$(info TRAVIS_COMMIT defined)
GIT_TAG?=${REPO}:$(TRAVIS_COMMIT)
BUILD_TAG?=${REPO}:${JAVA_VERSION}.${TRAVIS_BUILD_NUMBER}
BUILD_TAG_MAJOR?=${REPO}:${JAVA_VERSION_MAJOR}.${TRAVIS_BUILD_NUMBER}
TAGS?=${TAGS} -t ${GIT_TAG} -t ${BUILD_TAG} -t ${BUILD_TAG_MAJOR}
endif

all: build

docker:
	docker build --compress --squash --build-arg "JAVA_VERSION=${JAVA_VERSION}" ${TAGS} .

build: docker

push: build
	docker push ${VERSION_TAG}
	docker push ${VERSION_TAG_MAJOR}
ifdef TRAVIS_COMMIT
	docker push ${GIT_TAG}
	docker push ${BUILD_TAG}
	docker push ${BUILD_TAG_MAJOR}
endif

run: build
	docker run -i -t --rm --net=host \
	${REPO}:${JAVA_VERSION_MAJOR}

shell: build
	docker run -i -t --rm --net=host \
	${REPO}:${JAVA_VERSION_MAJOR} \
	/bin/bash


.PHONY: all build push docker push
