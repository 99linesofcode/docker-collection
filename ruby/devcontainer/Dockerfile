# syntax=docker/dockerfile:1

FROM ghcr.io/99linesofcode/devcontainer:latest

LABEL maintainer="Jordy Schreuders <jordy@schreuders.it>"

ARG DEBIAN_FRONTEND=noninteractive
ARG USER=abc
ARG BUILD_DEPS="autoconf bison patch build-essential rustc libssl-dev libyaml-dev libreadline6-dev zlib1g-dev libgmp-dev libncurses5-dev libffi-dev libgdbm6 libgdbm-dev libdb-dev uuid-dev"

ENV RUBY_VERSION="3.2.1"

SHELL ["zsh", "-c"]

USER root

RUN \
  echo "*** Installing Ruby through Asdf ***" \
  && apt-get update && apt-get install -y --no-install-recommends \
  $BUILD_DEPS \
  libmariadb-dev \
  && echo "*** Cleaning up build dependencies ***" \
  && apt-get -y autoremove \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

USER $USER

RUN \
  echo "*** Installing Ruby and Rails ***" \
  && source /config/.asdf/asdf.sh \
  && asdf plugin add ruby https://github.com/asdf-vm/asdf-ruby.git \
  && asdf install ruby $RUBY_VERSION \
  && asdf global ruby $RUBY_VERSION \
  && gem install rails
