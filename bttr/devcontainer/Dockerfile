# syntax=docker/dockerfile:1

ARG PHP_VERSION="8.1"
ARG PACKAGE_VERSION="php-${PHP_VERSION}"
ARG BASE_IMAGE="ghcr.io/99linesofcode/devcontainer:${PACKAGE_VERSION}"

FROM ${BASE_IMAGE}

LABEL org.opencontainers.image.authors="99linesofcode@gmail.com"

ARG DEBIAN_FRONTEND=noninteractive
# See https://docs.docker.com/engine/reference/builder/#understand-how-arg-and-from-interact
ARG PHP_VERSION
ARG TZ="Europe/Amsterdam"
ARG USER=abc

SHELL ["zsh", "-c"]

USER root

RUN \
  echo "*** Set timezone ***" \
  && echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen && locale-gen \
  && echo "*** Installing BTTR dependencies ***" \
  && apt-get update && apt-get install -y --no-install-recommends \
  libjpeg-turbo8-dev \
  libjpeg-turbo-progs \
  libxslt1-dev \
  imagemagick \
  optipng \
  gifsicle \
  php${PHP_VERSION}-gd \
  php${PHP_VERSION}-imagick \
  php${PHP_VERSION}-mysql \
  php${PHP_VERSION}-redis \
  php${PHP_VERSION}-xsl

# php${PHP_VERSION}-bcmath \
# php${PHP_VERSION}-curl \
# php${PHP_VERSION}-dev \
# php${PHP_VERSION}-imap \
# php${PHP_VERSION}-igbinary \
# php${PHP_VERSION}-intl \
# php${PHP_VERSION}-ldap \
# php${PHP_VERSION}-mbstring \
# php${PHP_VERSION}-memcached \
# php${PHP_VERSION}-msgpack \
# php${PHP_VERSION}-pcov \
# php${PHP_VERSION}-pgsql \
# php${PHP_VERSION}-readline \
# php${PHP_VERSION}-soap \
# php${PHP_VERSION}-sqlite3 \
# php${PHP_VERSION}-swoole \
# php${PHP_VERSION}-xml \
# php${PHP_VERSION}-xdebug \
# php${PHP_VERSION}-zip

USER $USER
