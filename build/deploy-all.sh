#!/bin/sh

#
# Variables
#
SCRIPT=$(readlink -f "$0")
DIR="$(dirname $SCRIPT)"
ROOT_DIR="$(dirname $DIR)"
BUILD_DIR="${ROOT_DIR}/build"
VERSIONS_DIR="${ROOT_DIR}/versions"

#
# Executing
#
for dirname in $(ls -d $VERSIONS_DIR/*/); 
do 
  version=$(basename $dirname); 
  make -s -C "${BUILD_DIR}" VERSION=${version} pull
  make -s -C "${BUILD_DIR}" VERSION=${version} release
  make -s -C "${BUILD_DIR}" VERSION=${version} push
done