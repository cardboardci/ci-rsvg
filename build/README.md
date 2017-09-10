# Docker Build

## Commands

You can use the [`Makefile`](build/Makefile) to perform a series of common tasks like: [ `build`, `test`, `push`, `pull` ]. These will handle the logic of building, tagging and pushing the image with the appropriate names and tags. 

```bash
make VERSION=myversion build
make VERSION=myversion test
make VERSION=myversion push
```

To see all the commands available from the [`Makefile`](build/Makefile), you can do the following:

```bash
make help
```

### Building

To build the docker image, use the included [`Makefile`](build/Makefile). It is recommended to use the makefile to ensure all build arguments are provided.

```bash
make VERSION=<version> build
```

You can also build the image manually, as visible in [`Makefile`](build/Makefile). However this is discouraged as the makefile ensures all build arguments are properly formatted. To add build arguments, it is best to use the `BUILD_PARAMS` variable that can be used in a `Makefile.options` file.

### Working with all versions

You can perform actions on all versions using the `ci/` scripts. These scripts can be called without any parameters and will perform an action all on all of the images. 

```bash
sh ci/build.sh
```

A make script is available as `ci/make.sh <function>` that will loop through each of the versions passing in the [`Makefile`](build/Makefile) arguments.

## Versioning

The image tags exist as definition files in the `versions/` directory. The `Makefile.options` file for each image tag allows the altering of variables in the build process. From the file the image tag is set, as well as any additional build parameters. Each `Makefile.options` file is stored in a directory named after the image version. The following is a `Makefile.options` file contained within the directory `versions/baseimage`:

```makefile
TAG := baseimage

BUILD_PARAMS := --build-arg USER="docker" --build-arg MINIFY_URL="github.com/tdewolff/minify/cmd/minify"

PATH_DOCKER := $(PATH_ROOT)/src
PATH_DOCKERFILE := $(PATH_DOCKER)/Dockerfile
```

You also have access to other variables in the `Makefile` that can be set. You can find some common variables in the Variables section.

### Variables

|Name|Description|Example|
|---|---|---|
|TAG|The tag of the image version.|`baseimage`|
|ALIASES|Additional tags of the image.|`myalias1 myalias2 myalias3`|
|BUILD_PARAMS|Additional build parameters passed to the [docker build](https://docs.docker.com/engine/reference/commandline/build/) command.|`--build-arg MY_ARG="value1"`|
|PATH_DOCKER| A directory to use as the build’s context. (Default is `src/`)|`$(PATH_ROOT)/src`|
|PATH_DOCKERFILE|Path of the Dockerfile. (Default is `src/Dockerfile`)|`$(PATH_DOCKER)/Dockerfile`|

You can look for other variables in any file that matches the regular expression `Makefile.*.variable`. These files are available in `info/` and `build/`, where they have variables relevant to the image and build respectively.

## Registries

The [Registry](https://docs.docker.com/registry/) is a stateless, highly scalable server side application that stores and lets you distribute Docker images. The Registry is open-source, under the permissive Apache license.

### Staging Registry

You can make use of a staging registry to store docker images that are not ready for deployment. This can be done by setting the environment variables `STAGING_REGISTRY`, `STAGING_NAMESPACE`, `STAGING_PROJECT`. You can see an example usage with [GitLab Container Registry](https://docs.gitlab.com/ce/user/project/container_registry.html), where in the `.gitlab-ci.yml` you can define the environment variables:

```yaml
STAGING_REGISTRY: registry.gitlab.com
STAGING_NAMESPACE: my-group
STAGING_PROJECT: my-docker-project
```

This allows you to build the docker image then push it to the staging repository. You can then pull from this repository in order to do testing with the image. When complete, you can simply retag the image and push to the standard registry.

### Deployment Registry

When you are ready to release your image into a production environment (however that looks), you can use. This can be done by setting the environment variables `REGISTRY`, `NAMESPACE`, `PROJECT`. These values have defaults assigned in the `Makefile.image.variable` file in the `info/` directory.

These environment variables can be overwritten in the `.gitlab-ci.yml`:

```yaml
REGISTRY: docker.io
NAMESPACE: my-organization
PROJECT: my-docker-image
```