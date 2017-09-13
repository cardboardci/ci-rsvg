#!/usr/bin/env bats

#
# Filesystem
#
DIR_TESTS="$(dirname $(readlink -f "$0"))"

DIR_LIBRARY="${DIR_TESTS}/lib"
DIR_RESOURCES="${DIR_TESTS}/resources"
DIR_TARGET="${DIR_TESTS}/target"

#
# Tests
#
@test "user is root" {
    run docker run --rm "${DOCKER_IMAGE_NAME}" id -u
    echo "status: $status"
    echo "output: $output"
    [ "$output" == "0" ]
}

@test "rsvg-convert is installed" {
	run docker run --rm --entrypoint sh "${DOCKER_IMAGE_NAME}" -c "which rsvg-convert"
    echo "status: $status"
    [ "$status" -eq 0 ]
}

@test "rsvg-iconset is installed" {
	run docker run --rm --entrypoint sh "${DOCKER_IMAGE_NAME}" -c "which rsvg-iconset"
    echo "status: $status"
    [ "$status" -eq 0 ]
}

@test "cache is empty" {
    run docker run --rm --entrypoint sh "${DOCKER_IMAGE_NAME}" -c "ls -1 /var/cache/apk/ | wc -l"
    echo "status: $status"
    [ "$status" -eq 0 ]
}

@test "tmp is empty" {
    run docker run --rm --entrypoint sh "${DOCKER_IMAGE_NAME}" -c "ls -1 /var/tmp/ | wc -l"
    echo "status: $status"
    [ "$status" -eq 0 ]
}

@test "apk is enabled" {
    run docker run --rm "${DOCKER_IMAGE_NAME}" apk add -U curl
    echo "status: $status"
    echo "output: $output"
    [ "$status" -eq 0 ]
}

@test "simple png" {
    run docker run --rm -v "${DOCKER_PATH}":/media "${DOCKER_IMAGE_NAME}" rsvg-convert resources/test.svg -o target/test.png
    echo "status: $status"
    echo "output: $output"
    [ "$status" -eq 0 ]
}

@test "icon-set of svg" {
    run docker run --rm -v "${DOCKER_PATH}":/media "${DOCKER_IMAGE_NAME}" rsvg-iconset -f resources/test.svg -o target/images/icon
    echo "status: $status"
    echo "output: $output"
    [ "$status" -eq 0 ]
}

@test "the image uses label-schema.org" {
    run docker inspect -f '{{ index .Config.Labels "org.label-schema.schema-version" }}' "${DOCKER_IMAGE_NAME}"
    echo "status: $status"
    echo "output: $output"
    [ "$status" -eq 0 ]
    [ "$output" = "1.0" ]
}

@test "the image has a build-date" {
    run docker inspect -f '{{ index .Config.Labels "org.label-schema.build-date" }}' "${DOCKER_IMAGE_NAME}"
    echo "status: $status"
    echo "output: $output"
    [ "$status" -eq 0 ]
    [ "$output" != "" ]
}

@test "the image has a maintainer" {
    run docker inspect -f '{{ index .Config.Labels "maintainer" }}' "${DOCKER_IMAGE_NAME}"
    echo "status: $status"
    echo "output: $output"
    [ "$status" -eq 0 ]
    [ "$output" != "" ]
}