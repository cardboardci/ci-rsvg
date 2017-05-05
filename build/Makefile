include Makefile.metadata.variable
include Makefile.image.variable

# Variables
#
# Common variables of the project.
DOCKER_IMAGE := ${REGISTRY}/${NAMESPACE}/${PROJECT}

# File System Variables
#
# Variables related to the file system paths.
DOCKER_DIR := ../src
DOCKER_FILE := Dockerfile
DOCKER_ROOT := $(shell dirname $(shell pwd))
DOCKERFILE := $(DOCKER_DIR)/$(DOCKER_FILE)

# Build Variables
#
# Variables used for the generic build
TAG ?= baseimage
USER ?= docker

.PHONY: build baseimage privileged test debug pull push prune clean  

all: 
	${MAKE} baseimage 
	${MAKE} privileged

release: 
	${MAKE} debug 
	${MAKE} baseimage 
	${MAKE} privileged
	${MAKE} push

# Build rules
#
# Build rules for the docker project.
build: 
	docker build --pull \
		 -t ${DOCKER_IMAGE}:$(TAG) \
		--build-arg BUILD_DATE="${BUILD_DATE}" \
		--build-arg VERSION="${CODE_VERSION}" \
		--build-arg VCS_REF="${GIT_COMMIT}" \
		--build-arg USER="${USER}" \
		-f ${DOCKERFILE} ${DOCKER_DIR}/.

baseimage: TAG=baseimage
baseimage: USER=docker
baseimage: build

privileged: TAG=privileged
privileged: USER=root
privileged: build

# Testing rules
#
# Test rules for docker projects.
test:
	docker run --rm -v $(DOCKER_ROOT)/test:/media ${DOCKER_IMAGE}:baseimage sh test.sh

# Generic rules
#
# Generic rules for docker projects.
debug:
	@echo Docker Image: $(DOCKER_IMAGE)

pull:
	docker pull --all-tags ${DOCKER_IMAGE}

push:
	docker push ${DOCKER_IMAGE}

prune:
	docker images -q -f dangling=true | xargs --no-run-if-empty docker rmi

clean:
	docker rmi --force ${DOCKER_IMAGE}:baseimage ${DOCKER_IMAGE}:privileged || exit 0