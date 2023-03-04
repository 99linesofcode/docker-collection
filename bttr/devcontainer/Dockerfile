# syntax=docker/dockerfile:1

ARG VERSION="8.1"
ARG BASE_IMAGE="ghcr.io/99linesofcode/devcontainer:${VERSION}"

FROM ${BASE_IMAGE}

LABEL maintainer="Jordy Schreuders <jordy@schreuders.it>"

ARG DEBIAN_FRONTEND=noninteractive
ARG USER=abc

SHELL ["zsh", "-c"]

USER root

RUN \
  echo "*** Installing BTTR dependencies ***" \
  && apt-get update && apt-get install -y --no-install-recommends \
  libjpeg-turbo8-dev \
  libjpeg-turbo-progs \
  libxslt1-dev \
  imagemagick \
  optipng \
  gifsicle \
  php${VERSION}-gd \
  php${VERSION}-imagick \
  php${VERSION}-mysql \
  php${VERSION}-redis \
  php${VERSION}-xsl

# php${VERSION}-bcmath \
# php${VERSION}-curl \
# php${VERSION}-dev \
# php${VERSION}-imap \
# php${VERSION}-igbinary \
# php${VERSION}-intl \
# php${VERSION}-ldap \
# php${VERSION}-mbstring \
# php${VERSION}-memcached \
# php${VERSION}-msgpack \
# php${VERSION}-pcov \
# php${VERSION}-pgsql \
# php${VERSION}-readline \
# php${VERSION}-soap \
# php${VERSION}-sqlite3 \
# php${VERSION}-swoole \
# php${VERSION}-xml \
# php${VERSION}-xdebug \
# php${VERSION}-zip

USER $USER
