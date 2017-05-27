#!/bin/sh

# Variables
#
# Variables of the script.
SCRIPT=$(readlink -f "$0")
DIR="$(dirname $SCRIPT)"
ROOT_DIR="$(dirname $DIR)"
BIN_DIR="${DIR}/target"
DATA_DIR="${DIR}/resources"

# Tests
#
# The functions that test certain functionality.

function install()
{
    apk add --update zip >/dev/null 2>&1
}

function simple_svg()
{
    rsvg-convert $DATA_DIR/test.svg -o $BIN_DIR/test.png
}

# Test Runner
#
# Runs the tests.
(
    function assertEquals()
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

    echo "Testing image for baseimage."
    mkdir -p $BIN_DIR
    (
      RESULT=$(install)
      assertEquals "cannot install to image" 243 $?
    )

    (
      RESULT=$(simple_svg)
      assertEquals "convert simple rsvg" 0 $?
    )
)