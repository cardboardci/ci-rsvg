#!/bin/sh

#
# Variables
#
SCRIPT=$(readlink -f "$0")
DIR="$(dirname $SCRIPT)"
DIR_ROOT="$(dirname $DIR)"

# Tests
#
# A set of common functions that should be tested on the docker image.

install()
{
    apk add --update zip >/dev/null 2>&1
}

simple_svg()
{
    rsvg-convert resources/test.svg -o target/test.png
}

# Framework
#
# Assertion functions used by the test functions.

assertEquals()
{
    msg=$1
    expected=$2
    actual=$3

    if [ "$expected" != "$actual" ]; then
        echo "$msg: FAILED: EXPECTED=$expected ACTUAL=$actual"
    else
        echo "$msg: PASSED"
    fi
}

assertNotEquals()
{
    msg=$1
    expected=$2
    actual=$3

    if [ "$expected" == "$actual" ]; then
        echo "$msg: FAILED: EXPECTED=$expected ACTUAL=$actual"
    else
        echo "$msg: PASSED"
    fi
}