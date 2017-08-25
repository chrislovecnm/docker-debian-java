# Yet another Java Container

[![Build Status](https://travis-ci.org/vorstella/docker-java.svg?branch=master)](https://travis-ci.org/vorstella/docker-java) 

Our base Ubuntu java container.

## Installed

- openjre
- openjdk-8-jre-headless
- libjemalloc1
- dumb-init

## Build Process

`make push` will use docker to push a container to registry of your choice.  By default container will be pushed to vorstella docker registry and tagged with `${GROUP_ID}/${PROJECT_ID}:${PROJECT_VERSION}-dev-${GIT_VERSION}`.  See the Makefile for values that can be overriden.

## Release Process

Builds are built from master continuously and released with a `alpha-${TRAVIS_COMMIT::9}-${TRAVIS_BUILD_NUMBER}` in the tag.  Full released versions are built when a git tag is added by a owner.

### Tagging

If your git remote is named upstream follow the following commands.  Otherwise push to the proper name of the git remote.

`
git tag <tagname>
git push upstream <tagname>
`

We follow a FIXME versioning standard starting with a "v".  For instance v1.0.2. The previous example would generate a container named: `vorstella/vorstella-java:${PROJECT_VERSION}-v1.0.2-${TRAVIS_BUILD_NUMBER}`. Policy is to never push the same tag twice.


