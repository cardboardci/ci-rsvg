# Dockerized librsvg
[![MIT License][license-badge]][license][![Alpine][alpine-badge]][alpine]

A super small Alpine image with rsvg-convert installed.

## Usage

You can use this image locally with `docker run`, calling [`rsvg-convert`](http://manpages.ubuntu.com/manpages/zesty/man1/rsvg-convert.1.html) as such:

```console
docker run -v /media:/media jrbeverly/rsvg rsvg-convert test.svg -o test.png
```

### Gitlab
You can add a build job with `.gitlab-ci.yml`

```yaml
compile_pdf:
  image: jrbeverly/rsvg
  script:
    - rsvg-convert test.svg -o test.png
  artifacts:
    paths:
      - test.png
```

## Image Tags

Build tags available with the image `jrbeverly/rsvg:{TAG}`.

| Tag | Status | Description |
| --- | ------ | ----------- |
| [latest](/../tree/latest) | [![build status](/../badges/latest/build.svg)](/../commits/latest) | An alpine image with librsvg installed. |
| [locked](/../tree/locked) | [![build status](/../badges/locked/build.svg)](/../commits/locked) | An alpine image with librsvg installed, with a non-root running user. |

## Components
### Build Arguments

Build arguments used in the system.

| Variable | Default | Description |
| -------- | ------- |------------ |
| BUILD_DATE | - | The date which the image was built. |
| VERSION | - | The version of the image. |
| DUID | see [Makefile](Makefile.image.variable) | The [user id](http://www.linfo.org/uid.html) of the docker user. |
| DGID | see [Makefile](Makefile.image.variable) | The [group id](http://www.linfo.org/uid.html) of the docker user's group. |

### Environment Variables

Environment variables used in the system.

| Variable | Default | Description |
| -------- | ------- |------------ |
| HOME | / | The pathname of the user's home directory. |

## Build Process

To build the docker image, use the included makefile.

```
make build
```

You can also build the image manually, but it is recommended to use the makefile to ensure all build arguments are provided.

```
docker build \
		--build-arg BUILD_DATE="$(date)" \
		--build-arg VERSION="${VERSION}" \
    ...
		--pull -t ${IMAGE}:${TAG} .
```

[license-badge]: https://img.shields.io/badge/license-MIT-blue.svg?maxAge=2592000
[license]: /../blob/master/LICENSE
[alpine-badge]: https://img.shields.io/badge/alpine-3.5-green.svg?maxAge=2592000
[alpine]: https://alpinelinux.org/posts/Alpine-3.5.0-released.html