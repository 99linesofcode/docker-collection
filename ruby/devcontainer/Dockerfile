# syntax=docker/dockerfile:1

ARG VERSION="latest"
ARG BASE_IMAGE="ghcr.io/99linesofcode/devcontainer:${VERSION}"

FROM ${BASE_IMAGE}

LABEL maintainer="Jordy Schreuders <jordy@schreuders.it>"

ARG DEBIAN_FRONTEND=noninteractive
ARG USER=abc
ARG BUILD_DEPS="autoconf bison patch build-essential rustc libssl-dev libyaml-dev libreadline6-dev zlib1g-dev libgmp-dev libncurses5-dev libffi-dev libgdbm6 libgdbm-dev libdb-dev uuid-dev"
ARG RUBY_VERSION="3.2.1"

SHELL ["/bin/sh", "-c"]

USER root

RUN \
  echo "*** Installing runtime packages ***" \
  && apt-get update && apt-get install -y --no-install-recommends \
  libmariadb-dev

USER $USER

SHELL ["zsh", "-c"]

RUN \
  echo "*** Installing Ruby and Rails ***" \
  && sudo apt-get update && apt-get install -y --no-install-recommends \
  $BUILD_DEPS \
  && source /config/.asdf/asdf.sh \
  && asdf plugin add ruby https://github.com/asdf-vm/asdf-ruby.git \
  && asdf install ruby ${RUBY_VERSION} \
  && asdf global ruby ${RUBY_VERSION} \
  && gem install rails \
  && echo "*** Cleaning up build dependencies ***" \
  && sudo apt-get -y autoremove \
  && sudo apt-get clean \
  && sudo rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
