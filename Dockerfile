ARG GO_VERSION=1.16-alpine3.12
ARG FROM_IMAGE=alpine:3.12

FROM --platform=${BUILDPLATFORM} golang:${GO_VERSION} AS builder
LABEL maintainer="Nho Luong <luongutnho@hotmail.com>"
ARG TARGETOS
ARG TARGETARCH

LABEL org.opencontainers.image.source="https://github.com/nholuongut/go-cli-template"

WORKDIR /app

COPY ./ /app

RUN apk update && \
  apk add ca-certificates gettext git make curl unzip && \
  rm -rf /tmp/* && \
  rm -rf /var/cache/apk/* && \
  rm -rf /var/tmp/*

RUN make build TARGETOS=$TARGETOS TARGETARCH=$TARGETARCH

FROM ${FROM_IMAGE}

COPY --from=builder /app/dist/go-cli /bin/go-cli

ENTRYPOINT ["go-cli"]
