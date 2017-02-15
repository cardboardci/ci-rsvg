include Makefile.metadata.variable
include Makefile.image.variable
include Makefile.user.variable

DOCKERFILE := src/.
TAG := latest

.PHONY: baseimage privileged clean prune push test pull

baseimage:
	docker build \
		--build-arg BUILD_DATE="${BUILD_DATE}" \
		--build-arg VERSION="${VERSION}" \
		--build-arg VCS_REF="${VCS_REF}" \
		--build-arg DUID="${DUID}" \
		--build-arg DGID="${DGID}" \
		--build-arg USER="docker" \
		--pull -t ${FULL_NAME}:latest ${DOCKERFILE}
	docker tag ${FULL_NAME}:latest ${FULL_NAME}:baseimage

privileged:
	docker build \
		--build-arg BUILD_DATE="${BUILD_DATE}" \
		--build-arg VERSION="${VERSION}" \
		--build-arg VCS_REF="${VCS_REF}" \
		--build-arg DUID="${DUID}" \
		--build-arg DGID="${DGID}" \
		--build-arg USER="root" \
		--pull -t ${FULL_NAME}:privileged ${DOCKERFILE}

test:
	docker run -v $(shell pwd)/test:/media ${FULL_NAME}:${TAG} rsvg-convert test.svg -o test.png

clean:
	docker rmi --force ${NAME}:baseimage ${NAME}:privileged || exit 0

prune:
	docker images -q -f dangling=true | xargs --no-run-if-empty docker rmi

pull:
	docker pull --all-tags ${FULL_NAME}

push:
	docker push ${FULL_NAME}

all: baseimage privileged