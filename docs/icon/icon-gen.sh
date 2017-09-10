#!/bin/sh
set -e

#
DIR=$(dirname $(readlink -f "$0"))
mkdir -p $DIR/images
docker run --rm -v $DIR:/media/ jrbeverly/rsvg:privileged rsvg-iconset -f icon.svg -o images/icon