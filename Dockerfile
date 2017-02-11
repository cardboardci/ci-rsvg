FROM alpine:3.5
MAINTAINER jrbeverly

# Environment Variables
#
# Environment variables present in the docker container.
ENV HOME=/

# Build Arguments
#
# Arguments used in the build process of the docker container.
ARG DUID
ARG DGID

# Provision
#
# Copy and execute provisioning scripts of the docker container.
RUN addgroup -g ${DGID} -S docker && adduser -S -G docker -u ${DUID} docker

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

#USER docker

# Metdata Arguments
#
# Arguments used for the metadata of the docker container.
ARG BUILD_DATE
ARG VERSION

# Metadata 
#
# The metadata of the image.
LABEL app="rsvg-convert"
LABEL description="Turn SVG files into raster images."
LABEL version="${VERSION}"
LABEL build_date="${BUILD_DATE}"
LABEL user="${DUID}"
LABEL group="${DGID}"