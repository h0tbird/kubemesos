#------------------------------------------------------------------------------
# Set the base image for subsequent instructions:
#------------------------------------------------------------------------------

FROM alpine:3.4
MAINTAINER Marc Villacorta Morera <marc.villacorta@gmail.com>

#------------------------------------------------------------------------------
# Environment variables:
#------------------------------------------------------------------------------

ENV VERSION="v1.3.7" \
    KUBERNETES_CONTRIB="mesos"

#------------------------------------------------------------------------------
# Install:
#------------------------------------------------------------------------------

RUN apk add --no-cache --update -t deps bash go git make gcc musl-dev \
    linux-headers rsync \
    && git clone https://github.com/kubernetes/kubernetes.git \
    && cd kubernetes; git checkout tags/${VERSION} -b ${VERSION} \
    && make WHAT=cmd/kubectl && make WHAT=contrib/mesos/cmd/km \
    && cp _output/local/bin/linux/amd64/* /usr/local/bin \
    && apk del --purge deps && rm -rf /kubernetes /tmp/* /var/cache/apk/*
