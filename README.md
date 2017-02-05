# Dockerized Alpine
[![MIT License][license-badge]][license][![Alpine][alpine-badge]][alpine]

A super small Alpine image with rsvg-convert installed.

## Usage

It is suggested to use this as either a template or a base image.

## Image Tags

Build tags available with the image `jrbeverly/rsvg:{TAG}`.

<table>
  <tr>
    <th width="7%">Tag</th>
    <th width="10%">Status</th> 
    <th>Description</th>
  </tr>
  <tr>
    <td><a href="/../tree/master">master</a></td>
    <td><a href="/../commits/master"><img alt="Build Status" src="/../badges/master/build.svg"/></a></td>
    <td>An alpine image with librsvg installed.</td>
  </tr>
</table>

## Components
### Build Arguments

Build arguments used in the system.

| Variable | Default | Description |
| -------- | ------- |------------ |
| BUILD_DATE | - | The date which the image was built. |
| VERSION | - | The version of the image. |

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

You can also build the image manually, but it is recommended to use the makefile.

```
docker build \
		--build-arg BUILD_DATE="$(date)" \
		--build-arg VERSION="${VERSION}" \
		--pull -t ${IMAGE}:${TAG} .
```

[license-badge]: https://img.shields.io/badge/license-MIT-blue.svg?maxAge=2592000
[license]: /../blob/master/LICENSE
[alpine-badge]: https://img.shields.io/badge/alpine-3.5-green.svg?maxAge=2592000
[alpine]: https://alpinelinux.org/posts/Alpine-3.5.0-released.html