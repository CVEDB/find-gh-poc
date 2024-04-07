FROM golang:1.17.2-alpine AS build-env

RUN apk add git
ADD . /go/src/find-gh-poc
WORKDIR /go/src/find-gh-poc
RUN go build -o find-gh-poc

FROM alpine:3.14
LABEL licenses.find-gh-poc.name="MIT" \
      licenses.find-gh-poc.url="https://github.com/cvedb/find-gh-poc/blob/main/LICENSE" \
      licenses.golang.name="bsd-3-clause" \
      licenses.golang.url="https://go.dev/LICENSE?m=text"

COPY --from=build-env /go/src/find-gh-poc/find-gh-poc /bin/find-gh-poc

RUN mkdir -p /hive/in /hive/out

WORKDIR /app
RUN apk add bash

ENTRYPOINT [ "find-gh-poc" ]
