# syntax=docker/dockerfile:1

FROM ghcr.io/99linesofcode/devcontainer:latest

LABEL maintainer="Jordy Schreuders <jordy@schreuders.it>"

ARG DEBIAN_FRONTEND=noninteractive
ARG BUILD_DEPS="autoconf bison patch build-essential rustc libssl-dev libyaml-dev libreadline6-dev zlib1g-dev libgmp-dev libncurses5-dev libffi-dev libgdbm6 libgdbm-dev libdb-dev uuid-dev"

ENV RUBY_VERSION="3.2.1"

SHELL ["/bin/bash", "-c"]

RUN \
  && echo "*** Install Ruby through ASDF ***" \
  && apt-get update && apt-get install -y --no-install-recommends \
  $BUILD_DEPS \
  && source /config/.asdf/asdf.sh \
  && asdf plugin add ruby https://github.com/asdf-vm/asdf-ruby.git \
  && asdf install ruby $RUBY_VERSION

USER $USER

RUN \
  echo "*** Setting up user environment ***" \
  && sudo chown -R $USER:$USER /app /config /defaults \
  # TODO this can probably be handled in .zshrc later on
  && export PATH="$HOME/.local/bin:$PATH"
