include Makefile.file.variable
include Makefile.metadata.variable

# Variables
#
# Variables used in the Makefile to specify the image
DEFAULT_VERSION := -no-version-set-
VERSION ?= $(DEFAULT_VERSION)
TAG_SUFFIX ?=
TAG_PREFIX ?=
BUILD_PARAMETERS =

# Validation
#
# All rules below this point require the following properties to hold
RULES := image build test pull push release deploy
ifneq (,$(filter $(RULES),$(MAKECMDGOALS)))
ifeq ($(VERSION),$(DEFAULT_VERSION))
$(error The version is not properly set for the command (make VERSION=<-> COMMAND))
endif
ifeq (,$(wildcard $(PATH_DOCKER)))
$(error The version [$(VERSION)] is not valid for this image.  See versions/ for possible image versions)
endif
ifeq (,$(wildcard $(PATH_OPTIONS)))
$(error The version [$(VERSION)] is incorrectly setup and does not have a 'Makefile.options')
endif
include $(PATH_OPTIONS)
endif

ifeq (,$(wildcard $(PATH_IMAGEFILE)))
$(error The docker image is defined in 'info/')
endif
include $(PATH_IMAGEFILE)

ifeq (,$(wildcard $(PATH_VERSIONFILE)))
$(error The version of the docker image is not present in 'info/')
endif

# Registry
#
# Sets up the staging repository 
STAGING_REGISTRY ?= $(REGISTRY)
STAGING_NAMESPACE ?= $(NAMESPACE)
STAGING_PROJECT ?= $(PROJECT)

# Variables
#
# Common variables of the project
IMAGE := ${REGISTRY}/${NAMESPACE}/${PROJECT}
STAGING_IMAGE := ${STAGING_REGISTRY}/${STAGING_NAMESPACE}/${STAGING_PROJECT}
WORKING_IMAGE ?= $(STAGING_IMAGE):$(TAG_PREFIX)$(TAG)$(TAG_SUFFIX)

## 
## Rules
##
.PHONY: build test prune purge clean debug pull push release image info debug check-env
default: info

# Output
#
# Output details about the variables of the build process.

# Prints the variable value (make debug-VARIABLE)
debug-%  : ; @echo $* = $($*)

# Prints a collection of relevant variables
info:
	@echo Image Version: $(VERSION)
	@echo CODE_VERSION = $(CODE_VERSION)
	@echo GIT_COMMIT = $(GIT_COMMIT)
	@echo BUILD_DATE = $(BUILD_DATE)
	@echo Working Image: $(WORKING_IMAGE)
	@echo
	@echo Registry:
	@echo IMAGE = $(IMAGE)
	@echo STAGING_IMAGE = $(STAGING_IMAGE)	
	@echo
	@echo Pathing:
	@echo PATH_DOCKER: $(PATH_DOCKER)
	@echo PATH_DOCKERFILE: $(PATH_DOCKERFILE)
	@echo PATH_BUILD = $(PATH_BUILD)
	@echo PATH_ROOT = $(PATH_ROOT)
	@echo PATH_VERSIONS = $(PATH_VERSIONS)
	@echo PATH_TESTS = $(PATH_TESTS)
	@echo
	@echo Versions:
	@echo $(shell ls ${PATH_VERSIONS} | tr "\n" " " )

# Tidy Up
#
# Facilitates cleaning of the docker images related to this image

# Removes unused images
prune:
	docker images -q -f dangling=true | xargs --no-run-if-empty docker rmi

# Removes the image (and all tags)
clean:
	docker images | grep $(STAGING_NAMESPACE)/$(STAGING_PROJECT) | tr -s ' ' | cut -d ' ' -f 3 | xargs --no-run-if-empty docker rmi

# Removes all images and containers
purge:
	docker ps -qa | xargs --no-run-if-empty docker rm -fv
	docker images -qa | xargs --no-run-if-empty docker rmi -f

# Build
#
# Builds the image pulling variables from the `.variable` files

# Prints the working name of the image. 
image: check-version check-tag
	@echo $(WORKING_IMAGE)

# Build the working image
build: check-path check-tag
	docker build --pull \
		 -t $(WORKING_IMAGE) \
		 \
		--build-arg BUILD_DATE="${BUILD_DATE}" \
		--build-arg VERSION="${CODE_VERSION}" \
		--build-arg VCS_REF="${GIT_COMMIT}" \
		\
		$(BUILD_PARAMS) \
		\
		-f $(PATH_DOCKERFILE) $(PATH_DOCKER)/. \

# Testing
#
# Run tests on the provided image

# Tests the working docker image
test: check-version check-tag check-test
	@echo Running '$(VERSION)' tests on $(WORKING_IMAGE).
	docker run --rm -v $(MOUNT_TESTS):/media $(WORKING_IMAGE) sh test/$(VERSION)/test.sh

# Registry 
#
# Facilitates pushing and pulling the image from a registry

# Pull the working docker image from a registry
pull: check-version check-tag
	docker pull $(WORKING_IMAGE)

# Push the working docker image to a registry
push: check-version check-tag
	docker push $(WORKING_IMAGE)

# Tag the working image as a release image
release: check-version check-tag
	docker tag $(WORKING_IMAGE) $(IMAGE):$(TAG)

# Push the docker image to a registry
deploy: check-version check-tag
	docker push $(IMAGE):$(TAG)

# Validation
#
# Validate properties about the code

# Ensures that the test path is valid
check-test:
ifeq (,$(wildcard $(PATH_DOCKER_TEST)/test.sh))
	$(error The testing for version [$(VERSION)] is not valid for this image.  See tests/test/ for possible image versions [$(PATH_DOCKER_TEST)/test.sh])
endif

# Ensures that the tag is set
check-tag:
ifndef TAG
	$(error The version [$(VERSION)] is incorrectly setup and does not have a 'TAG' variable)
endif

# Ensures that the version is set
check-version:
ifeq ($(VERSION),$(DEFAULT_VERSION))
	$(error The version is not properly set for the command (make VERSION=<-> COMMAND))
endif

# Ensures that the paths are valid
check-path:
ifeq (,$(wildcard $(PATH_DOCKER)))
	$(error The provided docker path is not valid for this image.  See versions/ for possible image versions [$(PATH_DOCKER)])
endif
ifeq (,$(wildcard $(PATH_DOCKERFILE)))
	$(error A dockerfile could not be found at the path $(PATH_DOCKERFILE))
endif
