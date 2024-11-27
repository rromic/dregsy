#
# Copyright 2020 Alexander Vollschwitz
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# Skopeo build, taken from https://github.com/bdwyertech/docker-skopeo
#
ARG GO_VERSION=1.23.3
FROM docker.io/golang:${GO_VERSION}-alpine3.20@sha256:03bea3386a1427e9de21b9278fdcf8a3941d41b92498866a47a91fe15cbf1dfa AS skopeo

ARG SKOPEO_VERSION

WORKDIR /go/src/github.com/containers/skopeo

RUN apk add --no-cache --virtual .build-deps \
        git build-base btrfs-progs-dev gpgme-dev linux-headers lvm2-dev \
    && git clone --single-branch --branch "${SKOPEO_VERSION}" \
        https://github.com/containers/skopeo.git . \
    && go build -ldflags="-s -w" -o bin/skopeo ./cmd/skopeo \
    && apk del .build-deps


# dregsy image
#
FROM docker.io/alpine:3.20@sha256:029a752048e32e843bd6defe3841186fb8d19a28dae8ec287f433bb9d6d1ad85

LABEL maintainer="vollschwitz@gmx.net"

ARG binaries

RUN apk update && apk upgrade && apk --update add --no-cache \
    ca-certificates \
    device-mapper-libs \
    gpgme

COPY --from=skopeo /go/src/github.com/containers/skopeo/bin/skopeo /usr/bin
COPY ${binaries}/dregsy /usr/local/bin

CMD ["dregsy", "-config=config.yaml"]
