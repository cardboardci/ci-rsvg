FROM alpine:3.6

#
# Provision
#
COPY rootfs/ /

COPY provision/install.sh /tmp/install.sh
RUN sh /tmp/install.sh && rm -f /tmp/install.sh

# 
# Options
# 
WORKDIR /media
ENTRYPOINT []
CMD []

#
# User
#
ARG DUID
ARG DGID
RUN addgroup -g ${DGID} -S docker && adduser -S -G docker -u ${DUID} docker

ARG USER
USER $USER

#
# Metadata Arguments
#
ARG BUILD_DATE
ARG VERSION
ARG VCS_REF

#
# Metadata
#
LABEL \
    maintainer="jrbeverly" \
    \
    org.label-schema.name="librsvg" \
    org.label-schema.summary="A super small Alpine image with rsvg-convert installed." \
    org.label-schema.description="Turn SVG files into raster images." \
    org.label-schema.maintainer="jrbeverly" \
    org.label-schema.build-date=$BUILD_DATE \
    org.label-schema.version=$VERSION \
    org.label-schema.url="http://manpages.ubuntu.com/manpages/zesty/man1/rsvg-convert.1.html" \
    org.label-schema.license="MIT" \
    org.label-schema.docker.cmd="docker run -v $(pwd):/media/ jrbeverly/rsvg:baseimage rsvg-convert test.svg -o test.png" \
    org.label-schema.vendor="jrbeverly" \
    org.label-schema.schema-version="1.0" \
    \
    org.label-schema.vcs-ref=$VCS_REF \
    org.label-schema.vcs-url="https://gitlab.com/jrbeverly-docker/docker-rsvg" \
    \
    org.doc-schema.project="rsvg" \
    org.doc-schema.summary="A docker image with librsvg installed, running as the $USER user." \
    org.doc-schema.user=$DUID \
    org.doc-schema.group=$DGID


