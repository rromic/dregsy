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

ARG GO_VERSION=1.23.3

# Use the Go version in the first stage
FROM golang:${GO_VERSION}-alpine AS go-builder

FROM xelalex/dregsy:latest-alpine

# install & configure Go
# Copy Go from the builder stage
COPY --from=go-builder /usr/local/go/ /usr/local/go/
ENV GOROOT=/usr/local/go/
ENV GOPATH=/go
ENV GOCACHE=/.cache
ENV PATH=${GOROOT}/bin:${GOPATH}/bin:${PATH}
RUN mkdir -p ${GOPATH}/src ${GOPATH}/bin ${GOPATH}/pkg ${GOCACHE}

# non-root user
ARG USER=go
ENV HOME=/home/${USER}
RUN apk add --update sudo --no-cache
RUN adduser -D ${USER} && \
    adduser ${USER} ping && \
    echo "${USER} ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/${USER} && \
    chmod 0440 /etc/sudoers.d/${USER}
USER ${USER}

WORKDIR ${GOPATH}

CMD ["go", "version"]
