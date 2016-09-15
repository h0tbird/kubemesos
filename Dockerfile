#------------------------------------------------------------------------------
# Set the base image for subsequent instructions:
#------------------------------------------------------------------------------

FROM alpine:3.4
MAINTAINER Marc Villacorta Morera <marc.villacorta@gmail.com>

#------------------------------------------------------------------------------
# Environment variables:
#------------------------------------------------------------------------------

ENV GOPATH="/go" \
    VERSION="v1.3.7" \
    KUBERNETES_CONTRIB="mesos"

#------------------------------------------------------------------------------
# Install:
#------------------------------------------------------------------------------

RUN apk add --no-cache --update -t deps bash go git make gcc musl-dev linux-headers \
    && git clone https://github.com/kubernetes/kubernetes.git \
    && cd kubernetes; git checkout tags/${VERSION} -b ${VERSION}

RUN make
RUN apk del --purge deps && rm -rf /go /tmp/* /var/cache/apk/*
