# Copyright 2017 Vorstella

# these must be  with a unique name for every project
PROJECT_ID?=java
PROJECT_VERSION?=8u131-b11
JAVA_VERSION?=${PROJECT_VERSION}-2ubuntu1.16.04.3

# TODO the next section is boilerplate and couple be pulled in somehow
# set if you change the group
GROUP_ID?=vorstella

# Base Varibles
REPO?=${GROUP_ID}/${PROJECT_ID}
DOCKER_BASE?=${REPO}:${PROJECT_VERSION}
BUILD_DATE=$(shell date -u +"%Y-%m-%dT%H:%M:%SZ")
GIT_VERSION=$(shell git describe --always)

# Setup Build Versions
ifdef TRAVIS
  $(info $$TRAVIS is [${TRAVIS}])
  $(info $$TRAVIS_TAG is [${TRAVIS_TAG}])
  $(info $$TRAVIS_EVENT_TYPE is [${TRAVIS_EVENT_TYPE}])
  $(info $$TRAVIS_BUILD_NUMBER is [${TRAVIS_BUILD_NUMBER}])
  $(info $$TRAVIS_PULL_REQUEST_SHA is [${TRAVIS_PULL_REQUEST_SHA::9}])
  $(info travis build)

  GIT_VERSION?=${TRAVIS_COMMIT::9}

  # tag release build
  ifdef TRAVIS_TAG
    DOCKER_HUB_BUILD=${DOCKER_BASE}-release-${TRAVIS_TAG}.${TRAVIS_BUILD_NUMBER}
    $(info travis release: [${DOCKER_HUB_BUILD}])
  endif

  # pull request
  ifeq (${TRAVIS_EVENT_TYPE},pull_request)
    DOCKER_HUB_BUILD=${DOCKER_BASE}-beta-${TRAVIS_PULL_REQUEST_SHA::9}.${TRAVIS_BUILD_NUMBER}
    $(info travis pull request: [${DOCKER_HUB_BUILD}])
  else
    DOCKER_HUB_BUILD=${DOCKER_BASE}-alpha-${GIT_VERSION}.${TRAVIS_BUILD_NUMBER}
    $(info travis cron: [${DOCKER_HUB_BUILD}])
  endif

  QUAY_BUILD:=quay.io/${DOCKER_HUB_BUILD}
  TAGS=-t ${QUAY_BUILD} -t ${DOCKER_HUB_BUILD}
else
  $(info local build)
  DOCKER_HUB_BUILD=${DOCKER_BASE}-alpha-${GIT_VERSION}
  TAGS=-t ${DOCKER_HUB_BUILD}
endif

all: build

docker:
	docker build --compress \
	--build-arg="JAVA_VERSION=${JAVA_VERSION}" \
	--build-arg="BUILD_DATE=${BUILD_DATE}" \
	--build-arg="VCS_REF=${GIT_VERSION}" \
	${TAGS} .

build: docker

# FIXME if this fails the build is still marked as successful
push-docker-hub:
	docker push ${DOCKER_HUB_BUILD}

push-quay:
	docker push ${QUAY_BUILD}

push: push-docker-hub

run: build
	docker run -i -t --rm --net=host \
	${DOCKER_BASE}

shell: build
	docker run -i -t --rm --net=host \
	${DOCKER_BASE} \
	/bin/bash

.PHONY: all build push docker push push-docker-hub push-quay run shell
