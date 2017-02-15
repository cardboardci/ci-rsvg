FROM alpine:3.5
MAINTAINER jrbeverly

# Environment Variables
#
# Environment variables present in the docker container.
ENV HOME=/

# Provision
#
# Copy and execute provisioning scripts of the docker container.
COPY provision/install /tmp/install
RUN sh /tmp/install && rm -f /tmp/install 

# Volumes
#
# Volumes exposed by the docker container
VOLUME /media

# Options
#
# Configuration options of the docker container
WORKDIR /media
ENTRYPOINT []
CMD []

# User Arguments
#
# Arguments used in the user process of the docker container.
ARG DUID
ARG DGID
ARG USER

# User
#
# Configuration of the docker user for container execution.
RUN addgroup -g ${DGID} -S docker && adduser -S -G docker -u ${DUID} docker
USER ${USER}

# Metdata Arguments
#
# Arguments used for the metadata of the docker container.
ARG BUILD_DATE
ARG VERSION
ARG VCS_REF

# Metadata 
#
# The metadata of the image.
LABEL \
    io.gitlab.jrbeverly.name="rsvg-convert" \
    io.gitlab.jrbeverly.description="Turn SVG files into raster images." \
    io.gitlab.jrbeverly.url="http://manpages.ubuntu.com/manpages/zesty/man1/rsvg-convert.1.html" \
    io.gitlab.jrbeverly.vendor="Gnome" \
    io.gitlab.jrbeverly.license="MIT" \
    io.gitlab.jrbeverly.vcs-type="Git" \
    io.gitlab.jrbeverly.vcs-ref="${VCS_REF}" \
    io.gitlab.jrbeverly.vcs-url="https://gitlab.com/jrbeverly-docker/docker-rsvg.git" \
    io.gitlab.jrbeverly.ci-build-url="https://gitlab.com/jrbeverly-docker/docker-rsvg/commits/latest" \
    io.gitlab.jrbeverly.version="${VERSION}" \
    io.gitlab.jrbeverly.build-date="${BUILD_DATE}" \
    io.gitlab.jrbeverly.user="${DUID}" \
    io.gitlab.jrbeverly.group="${DGID}" \