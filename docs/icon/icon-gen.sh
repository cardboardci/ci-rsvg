#!/bin/sh
command -v docker >/dev/null 2>&1 || { echo >&2 "The script requires 'docker' but it's not installed.  Aborting."; exit 1; }

#
DIR=$(dirname "$(readlink -f "$0")")
mkdir -p "$DIR/images"
docker run --rm -v "$DIR":/media/ jrbeverly/rsvg:privileged rsvg-iconset -f icon.svg -o images/icon