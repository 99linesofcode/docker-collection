# syntax=docker/dockerfile:1

ARG PACKAGE_VERSION="latest"

FROM ghcr.io/99linesofcode/php-devcontainer:$PACKAGE_VERSION

LABEL maintainer="Jordy Schreuders <jordy@schreuders.it>"

ARG DEBIAN_FRONTEND=noninteractive
ARG USER=abc
ARG PHP_VERSION="8.0"

SHELL ["zsh", "-c"]

USER root

RUN \
  echo "*** Installing BTTR dependencies ***" \
  libjpeg-turbo8-dev \
  libjpeg-turbo-progs \
  libxslt1-dev \
  imagemagick \
  optipng \
  gifsicle \
  php$PHP_VERSION-imagick \
  php$PHP_VERSION-xsl

USER $USER
