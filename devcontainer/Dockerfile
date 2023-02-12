# syntax=docker/dockerfile:1

FROM ubuntu:22.04

LABEL maintainer="Jordy Schreuders <jordy@schreuders.it>"

ARG DEBIAN_FRONTEND=noninteractive
ARG USER=abc
ARG PUID=1000
ARG PGID=1000

ENV TZ="Europe/Amsterdam"
ENV NEOVIM_VERSION="nightly"
ENV NODE_VERSION="lts"

SHELL ["/bin/bash", "-c"]

RUN \
  ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ >> /etc/timezone \
  && echo "*** Install base dependencies ***" \
  && apt-get update && apt-get install -y --no-install-recommends \
  gnupg \
  software-properties-common \
  ca-certificates \
  sudo \
  build-essential \
  gnupg \
  ssh \
  curl \
  git \
  $VIM_DEPS \
  fzf \
  ripgrep \
  zsh \
  && echo "*** Set up container user ***" \
  && useradd -u $PUID -U -d /config -s /bin/zsh -G users $USER \
  && echo "abc ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers.d/$USER \
  && chmod 0440 /etc/sudoers.d/$USER \
  && mkdir -p /app /config/.local/bin /defaults \
  && echo "*** Set up Asdf ***" \
  && git clone https://github.com/asdf-vm/asdf.git /config/.asdf \
  && source /config/.asdf/asdf.sh \
  && asdf plugin add neovim https://github.com/richin13/asdf-neovim.git \
  && asdf plugin add nodejs https://github.com/asdf-vm/asdf-nodejs.git \
  && asdf install nodejs $NODE_VERSION \
  && asdf install neovim $NEOVIM_VERSION \
  && echo "*** Cleaning up build dependencies ***" \
  && apt-get -y autoremove \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
