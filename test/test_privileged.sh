#!/bin/sh

# Variables
#
# Variables of the script.
SCRIPT=$(readlink -f "$0")
DIR="$(dirname $SCRIPT)"
ROOT_DIR="$(dirname $DIR)"
BIN_DIR="${DIR}/target"
DATA_DIR="${DIR}/resources"
LIB_DIR="${DIR}/lib"

# Tests
#
# The functions that test certain functionality.

source $LIB_DIR/testbase.sh

# Test Runner
#
# Runs the tests.
(
    mkdir -p $BIN_DIR
    (
      RESULT=$(install)
      assertEquals "install to image" 0 $?
    )

    (
      RESULT=$(simple_svg)
      assertEquals "convert simple rsvg" 0 $?
    )
)