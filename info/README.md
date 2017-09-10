# Docker Info

A constants folder that stores global variables for the docker repository.

## Project Version

The project version is defined in the `info/VERSION` file.

## Makefile.image.variable

The project build requires the `Makefile.image.variable` file to store the variables `REGISTRY`, `NAMESPACE`, and `PROJECT`. The variables are defined below:

|Variable|Description|
|---|---|
|REGISTRY|The path to the Docker registry.|
|NAMESPACE|The namespace of the Docker image.|
|PROJECT|The name of the Docker image.|

You can define the `Makefile.image.variable` file as such:

```makefile
REGISTRY ?= docker.io
NAMESPACE ?= my-namespace
PROJECT ?= my-project
```

The `Makefile.image.variable` file will be loaded last.

## Makefile.options

The project build requires the `Makefile.options` file to provide the `TAG` variable. Other useful variables are:

|Variable|Description|
|---|---|
|TAG|The tag of the image.|
|ALIASES|Additional tags of the image. **[Optional]**|
|BUILD_PARAMS|Additional build parameters passed to the [docker build](https://docs.docker.com/engine/reference/commandline/build/) command.|
|PATH_DOCKER|A directory to use as the build’s context. (Default is `src/`)|
|PATH_DOCKERFILE|The Dockerfile to use. (Default is `src/Dockerfile`)|

You can define the `Makefile.options` file as such:

```makefile
TAG := mytag

BUILD_PARAMS := --build-arg MY_PARAM="params" 

PATH_DOCKER := $(PATH_ROOT)/src
PATH_DOCKERFILE := $(PATH_DOCKER)/Dockerfile
```

The `Makefile.options` file will be loaded after the global variables.

## Makefile.*.variable

The `Makefile` present in the `build/` directory loads all files that match the regular expression `Makefile.*.variable` in the `info/` directory. These variables will be loaded by the `Makefile`.

These `Makefile.*.variable` files will be loaded first.