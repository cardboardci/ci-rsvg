FROM jrbeverly/baseimage:alpine-3.5

#
# Provision
#
COPY provision/install.sh /tmp/install.sh
RUN sh /tmp/install.sh && rm -f /tmp/install.sh

#
# User Arguments
#
ARG USER

#
# User
#
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
    org.label-schema.name="rsvg" \
    org.label-schema.summary="A super small Alpine image with rsvg-convert installed." \
    org.label-schema.description="Turn SVG files into raster images." \
    org.label-schema.maintainer="jrbeverly" \
    org.label-schema.build-date=$BUILD_DATE \
    org.label-schema.version=$VERSION \
    org.label-schema.url="http://manpages.ubuntu.com/manpages/zesty/man1/rsvg-convert.1.html" \
    org.label-schema.license="MIT" \
    org.label-schema.vcs-type="Git" \
    org.label-schema.vcs-ref=$VCS_REF \
    org.label-schema.vcs-url="https://gitlab.com/jrbeverly-docker/docker-rsvg" \
    org.label-schema.docker.cmd="docker run -v /media/:/media/ jrbeverly/rsvg:baseimage rsvg-convert test.svg -o test.png" \
    \
    io.jrbeverly.project="rsvg" \
    io.jrbeverly.summary="Runs the application as the $USER user." \
    io.jrbeverly.rsvg.meta.BUILD_DATE="The Date/Time the image was built." \
    io.jrbeverly.rsvg.meta.VERSION="Release identifier for the contents of the image." \
    io.jrbeverly.rsvg.meta.VCS_REF="Identifier for the version of the source code from which this image was built." \
    io.jrbeverly.rsvg.args.USER="Sets the [user](http://www.linfo.org/uid.html) to use when running the image." \
    io.jrbeverly.rsvg.volume.media="/media/|The default working directory of the image." \
    io.jrbeverly.rsvg.tags.baseimage="baseimage|A docker image with librsvg installed, running as docker user (`DUID`)." \
    io.jrbeverly.rsvg.tags.privileged="privileged|A docker image with librsvg installed."
