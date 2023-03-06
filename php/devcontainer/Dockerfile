# syntax=docker/dockerfile:1

ARG PHP_VERSION="8.1"
ARG PACKAGE_VERSION="base-ubuntu22.04"
ARG BASE_IMAGE="ghcr.io/99linesofcode/devcontainer:${PACKAGE_VERSION}"

FROM ${BASE_IMAGE}

LABEL org.opencontainers.image.authors="99linesofcode@gmail.com"

ARG DEBIAN_FRONTEND=noninteractive
# See https://docs.docker.com/engine/reference/builder/#understand-how-arg-and-from-interact
ARG PHP_VERSION
ARG TZ="Europe/Amsterdam"
ARG USER=abc

USER root

SHELL ["/bin/sh", "-c"]

RUN \
  echo "*** Set timezone ***" \
  && ln -snf /usr/share/zoneinfo/${TZ} /etc/localtime && echo ${TZ} >> /etc/timezone \
  && echo "*** Installing PHP ***" \
  && mkdir -p $HOME/.gnupg \
  && chmod 600 $HOME/.gnupg \
  && echo "disable-ipv6" >> $HOME/.gnupg/dirmngr.conf \
  && echo "keyserver hkp://keyserver.ubuntu.com:80" >> $HOME/.gnupg/dirmngr.conf \
  && gpg --recv-key 0x14aa40ec0831756756d7f66c4f4ea0aae5267a6c \
  && gpg --export 0x14aa40ec0831756756d7f66c4f4ea0aae5267a6c >> /usr/share/keyrings/ppa_ondrej_php.gpg \
  && echo "deb [signed-by=/usr/share/keyrings/ppa_ondrej_php.gpg] https://ppa.launchpadcontent.net/ondrej/php/ubuntu jammy main" >> /etc/apt/sources.list.d/ppa_ondrej_php.list \
  && apt-get update && apt-get install -y --no-install-recommends \
  php${PHP_VERSION}-cli \
  && echo "*** Cleaning up build dependencies ***" \
  && apt-get -y autoremove \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

USER $USER

SHELL ["/bin/zsh", "-c"]

RUN \
  echo "*** Installing Composer to $HOME/.local/bin ***" \
  && php -r "readfile('https://getcomposer.org/installer');" | php -- --install-dir=/config/.local/bin --filename=composer
