#!/bin/sh
set -ex
cd /tmp/

apk add --update --no-cache librsvg

chmod +x /usr/bin/rsvg-*

rm -rf /tmp/* /var/tmp/* /var/cache/apk/*