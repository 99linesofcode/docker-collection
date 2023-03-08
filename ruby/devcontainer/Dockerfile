# syntax=docker/dockerfile:1

ARG RUBY_VERSION="3.2.1"
ARG PACKAGE_VERSION="base-ubuntu22.04"
ARG BASE_IMAGE="ghcr.io/99linesofcode/devcontainer:${PACKAGE_VERSION}"

FROM ${BASE_IMAGE}

LABEL maintainer="Jordy Schreuders <jordy@schreuders.it>"

ARG DEBIAN_FRONTEND=noninteractive
# See https://docs.docker.com/engine/reference/builder/#understand-how-arg-and-from-interact
ARG RUBY_VERSION
ARG USER=abc

WORKDIR /config/www

USER root

SHELL ["/bin/sh", "-c"]

RUN \
  echo "*** Installing runtime packages ***" \
  && apt-get update && apt-get install -y --no-install-recommends \
  # asdf dependencies
  autoconf \
  bison \
  patch \
  build-essential \
  rustc \
  libssl-dev \
  libyaml-dev \
  libreadline6-dev \
  zlib1g-dev \
  libgmp-dev \
  libncurses5-dev \
  libffi-dev \
  libgdbm6 \
  libgdbm-dev \
  libdb-dev \
  uuid-dev \
  #
  libmariadb-dev \
  && echo "*** Cleaning up build dependencies ***" \
  && apt-get -y autoremove \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

USER ${USER}

SHELL ["/bin/zsh", "-c"]

RUN \
  echo "*** Installing Ruby and Rails ***" \
  && source /config/.asdf/asdf.sh \
  && asdf plugin add ruby https://github.com/asdf-vm/asdf-ruby.git \
  && asdf install ruby ${RUBY_VERSION} \
  && asdf global ruby ${RUBY_VERSION} \
  && gem install rails
