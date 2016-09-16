#------------------------------------------------------------------------------
# Set the base image for subsequent instructions:
#------------------------------------------------------------------------------

FROM alpine:3.4
MAINTAINER Marc Villacorta Morera <marc.villacorta@gmail.com>

#------------------------------------------------------------------------------
# Environment variables:
#------------------------------------------------------------------------------

ENV GOPATH="/go" \
    VERSION="v1.4.0-beta.5" \
    KUBERNETES_CONTRIB="mesos"

ENV PATH="${PATH}:${GOPATH}/bin"

#------------------------------------------------------------------------------
# Install:
#------------------------------------------------------------------------------

RUN apk add --no-cache --update -t deps bash go git make gcc musl-dev \
    linux-headers rsync grep findutils coreutils \
    && git clone https://github.com/kubernetes/kubernetes.git \
    && cd kubernetes; git checkout tags/${VERSION} -b ${VERSION} \
    && go get -u github.com/jteeuwen/go-bindata/go-bindata \
    && make WHAT=cmd/kubectl && make WHAT=contrib/mesos/cmd/km \
    && cp _output/local/bin/linux/amd64/* /usr/local/bin \
    && apk del --purge deps && rm -rf /go /kubernetes /var/cache/apk/*
