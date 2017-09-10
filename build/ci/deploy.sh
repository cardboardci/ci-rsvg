#!/bin/sh
. "$(dirname $(readlink -f "$0"))"/make.sh

#
# Executing
#
call_make release
call_make deploy