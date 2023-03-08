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

WORKDIR /app

USER root

SHELL ["/bin/zsh", "-c"]

RUN \
  echo "*** Set timezone ***" \
  && ln -snf /usr/share/zoneinfo/${TZ} /etc/localtime && echo ${TZ} >> /etc/timezone \
  && echo "*** Installing BTTR dependencies ***" \
  && apt-get update && apt-get install -y --no-install-recommends \
  libjpeg-turbo8-dev \
  libjpeg-turbo-progs \
  libxslt1-dev \
  imagemagick \
  optipng \
  gifsicle \
  php${PHP_VERSION}-xsl

USER $USER
