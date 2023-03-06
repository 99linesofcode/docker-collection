# syntax=docker/dockerfile:1

ARG PHP_VERSION="8.1"
ARG PACKAGE_VERSION="${PHP_VERSION}"
ARG BASE_IMAGE="ghcr.io/99linesofcode/php:${PACKAGE_VERSION}"

FROM ${BASE_IMAGE}

LABEL org.opencontainers.image.authors="99linesofcode@gmail.com"

# See https://docs.docker.com/engine/reference/builder/#understand-how-arg-and-from-interact
ARG PHP_VERSION

RUN \
  export PHP_VERSION="$(echo ${PHP_VERSION} | sed 's/\.//')" \
  && echo "*** Installing runtime packages ***" \
  && apk add --no-cache --upgrade \
  php${PHP_VERSION}-pecl-xdebug
