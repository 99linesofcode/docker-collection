# syntax=docker/dockerfile:1

ARG VERSION="8.1"
ARG BASE_IMAGE="ghcr.io/99linesofcode/php:${VERSION}"

FROM ${BASE_IMAGE}

LABEL maintainer="Jordy Schreuders <jordy@schreuders.it>"

ARG VERSION=${VERSION//./}

RUN \
  echo "*** Installing runtime packages ***" && \
  apk add --no-cache --upgrade \
  PHP${VERSION}-pecl-redis \
  php${VERSION}-pecl-xdebug
