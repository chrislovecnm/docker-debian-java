# Copyright 2017 Vorstella
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

VERSION?=8u141
GROUP_ID?=vorstella
REGISTRY_ID?=quay.io
PROJECT_ID?=debian-java
PROJECT?=${REGISTRY_ID}/${GROUP_ID}/${PROJECT_ID}

all: build

docker:
	docker build --compress --squash -t ${PROJECT}:${VERSION} .

build: docker

push: build
	docker push ${PROJECT}:${VERSION}


.PHONY: all build push docker
