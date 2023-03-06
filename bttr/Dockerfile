# syntax=docker/dockerfile:1

ARG PHP_VERSION="8.1"
ARG PACKAGE_VERSION="${PHP_VERSION}"
ARG BASE_IMAGE="ghcr.io/99linesofcode/php:${PACKAGE_VERSION}"

FROM ${BASE_IMAGE}

LABEL org.opencontainers.image.authors="99linesofcode@gmail.com"

# See https://docs.docker.com/engine/reference/builder/#understand-how-arg-and-from-interact
ARG PHP_VERSION

RUN \
  export PACKAGE_VERSION="$(echo ${PHP_VERSION} | sed -E 's/(\.0?)+//g'" \
  && echo "*** Installing BTTR dependencies ***" \
  && apk add --no-cache --upgrade \
  mariadb-client \
  mariadb-connector-c \
  libjpeg-turbo-utils \
  optipng \
  gifsicle \
  php${PHP_VERSION}-calendar \
  php${PHP_VERSION}-exif \
  php${PHP_VERSION}-gd \
  php${PHP_VERSION}-soap \
  php${PHP_VERSION}-xsl \
  php${PHP_VERSION}-pcntl \
  php${PHP_VERSION}-sodium \
  php${PHP_VERSION}-xmlreader \
  php${PHP_VERSION}-pecl-xdebug \
  php${PHP_VERSION}-pecl-imagick

COPY php/root/ /
