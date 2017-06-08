#!/bin/sh

#
# Variables
#
SCRIPT=$(readlink -f "$0")
DIR="$(dirname $SCRIPT)"
DIR_TESTS="$(dirname $(dirname $DIR))"

DIR_LIBRARY="${DIR_TESTS}/lib"
DIR_RESOURCES="${DIR_TESTS}/resources"
DIR_TARGET="${DIR_TESTS}/target"

#
# Tests
#
source $DIR_LIBRARY/testbase.sh

# 
# Test Runner
#
(
    mkdir -p $DIR_TARGET
    (
      RESULT=$(install)
      assertEquals "install to image" 0 $?
    )

    (
      RESULT=$(simple_svg)
      assertEquals "convert simple rsvg" 0 $?
    )
)