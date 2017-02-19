include Makefile.metadata.variable
include Makefile.image.variable
include Makefile.user.variable

DOCKERFILE := src/.

TAG := latest
BASE_TAG := baseimage
ROOT_TAG := privileged
CONTAINER := ${FULL_NAME}:${BASE_TAG}
CONTAINER_ROOT := ${FULL_NAME}:${ROOT_TAG}

.PHONY: baseimage privileged test clean prune get-base get-privileged pull push deploy

default: all

baseimage:
	docker build \
		--build-arg BUILD_DATE="${BUILD_DATE}" \
		--build-arg VERSION="${VERSION}" \
		--build-arg VCS_REF="${VCS_REF}" \
		--build-arg DUID="${DUID}" \
		--build-arg DGID="${DGID}" \
		--build-arg USER="docker" \
		--pull -t ${CONTAINER} ${DOCKERFILE}
	docker tag ${CONTAINER} ${FULL_NAME}:${TAG}

privileged:
	docker build \
		--build-arg BUILD_DATE="${BUILD_DATE}" \
		--build-arg VERSION="${VERSION}" \
		--build-arg VCS_REF="${VCS_REF}" \
		--build-arg DUID="${DUID}" \
		--build-arg DGID="${DGID}" \
		--build-arg USER="root" \
		--pull -t ${CONTAINER_ROOT} ${DOCKERFILE}

test:
	docker run -v $(shell pwd)/test:/media ${FULL_NAME}:${TAG} sh test.sh

clean:
	docker rmi --force ${CONTAINER} ${CONTAINER_ROOT} || exit 0

prune:
	docker images -q -f dangling=true | xargs --no-run-if-empty docker rmi

get-base:
	docker pull ${CONTAINER}

get-privileged:
	docker pull ${CONTAINER_ROOT}

pull:
	docker pull --all-tags ${FULL_NAME}

push:
	docker push ${FULL_NAME}

deploy:
	docker tag ${FULL_NAME}:${TAG} ${RELEASE}:${TAG}
	docker tag ${FULL_NAME}:${BASE_TAG} ${RELEASE}:${BASE_TAG}
	docker tag ${FULL_NAME}:${ROOT_TAG} ${RELEASE}:${ROOT_TAG}
	docker push ${RELEASE}

all: baseimage privileged