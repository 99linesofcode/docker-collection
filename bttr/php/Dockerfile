# syntax=docker/dockerfile:1

ARG PACKAGE_VERSION="8.1"

FROM ghcr.io/99linesofcode/php:$PACKAGE_VERSION

LABEL maintainer="Jordy Schreuders <jordy@schreuders.it>"

ARG PHP_VERSION="81"

# https://github.com/just-containers/s6-overlay#customizing-s6-behaviour
ENV S6_BEHAVIOUR_IF_STAGE2_FAILS=2

RUN \
  echo "*** Installing BTTR dependencies ***" && \
  apk add --no-cache --upgrade \
  mariadb-client \
  mariadb-connector-c \
  libjpeg-turbo-utils \
  optipng \
  gifsicle \
  php$PHP_VERSION-calendar \
  php$PHP_VERSION-exif \
  php$PHP_VERSION-gd \
  php$PHP_VERSION-soap \
  php$PHP_VERSION-xsl \
  php$PHP_VERSION-pcntl \
  php$PHP_VERSION-sodium \
  php$PHP_VERSION-xmlreader \
  php$PHP_VERSION-pecl-imagick

COPY root/ /
