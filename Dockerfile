# syntax=docker/dockerfile:1.7

FROM golang:1.25-bookworm

ARG BUF_VERSION=1.64.0
ARG AIR_VERSION=1.64.5
ARG OAPI_CODEGEN_VERSION=2.4.1
ARG ORAS_VERSION=1.1.0

RUN apt-get update \
 && apt-get install -y --no-install-recommends \
      git \
      bash \
      curl \
      openssh-client \
      ca-certificates \
      inotify-tools \
 && rm -rf /var/lib/apt/lists/*

RUN curl -sSL "https://github.com/bufbuild/buf/releases/download/v${BUF_VERSION}/buf-Linux-$(uname -m)" \
      -o /usr/local/bin/buf \
 && chmod +x /usr/local/bin/buf

RUN curl -fsSL -o /tmp/oras.tar.gz \
      "https://github.com/oras-project/oras/releases/download/v${ORAS_VERSION}/oras_${ORAS_VERSION}_linux_$(dpkg --print-architecture).tar.gz" \
    && tar -xzf /tmp/oras.tar.gz -C /usr/local/bin oras \
    && rm /tmp/oras.tar.gz

RUN GOBIN=/usr/local/bin go install github.com/air-verse/air@v${AIR_VERSION}

RUN GOBIN=/usr/local/bin go install github.com/oapi-codegen/oapi-codegen/v2/cmd/oapi-codegen@v${OAPI_CODEGEN_VERSION}

WORKDIR /opt/app

RUN useradd -m -u 1000 -s /bin/bash godev \
 && mkdir -p /go /opt/app \
 && chown -R godev:godev /go /opt/app

ENV GOPATH=/go
ENV PATH=/go/bin:$PATH

USER godev

CMD ["sleep", "infinity"]
