#!/bin/sh
set -ex
cd /tmp/

apk add --update --no-cache librsvg

rm -rf /tmp/* /var/tmp/* /var/cache/apk/*