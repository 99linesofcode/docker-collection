# syntax=docker/dockerfile:1

ARG VERSION="8.1"
ARG BASE_IMAGE="ghcr.io/99linesofcode/php:${VERSION}"

FROM ${BASE_IMAGE}

LABEL maintainer="Jordy Schreuders <jordy@schreuders.it>"

RUN \
  echo "*** Installing BTTR dependencies ***" && \
  apk add --no-cache --upgrade \
  mariadb-client \
  mariadb-connector-c \
  libjpeg-turbo-utils \
  optipng \
  gifsicle \
  php${VERSION}-calendar \
  php${VERSION}-exif \
  php${VERSION}-gd \
  php${VERSION}-soap \
  php${VERSION}-xsl \
  php${VERSION}-pcntl \
  php${VERSION}-sodium \
  php${VERSION}-xmlreader \
  php${VERSION}-pecl-imagick
