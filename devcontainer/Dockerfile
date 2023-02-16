# syntax=docker/dockerfile:1

ARG PACKAGE_VERSION="22.04"

FROM ubuntu:$PACKAGE_VERSION

LABEL maintainer="Jordy Schreuders <jordy@schreuders.it>"

ARG DEBIAN_FRONTEND=noninteractive
ARG USER=abc
ARG PUID=1000
ARG PGID=1000
ARG NEOVIM_VERSION="nightly"

ENV TZ="Europe/Amsterdam"

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
  zip \
  unzip \
  git \
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
  && asdf install neovim $NEOVIM_VERSION \
  && echo "*** Install nodejs versions ***" \
  && asdf install nodejs 16.19.0 \
  && asdf install nodejs 18.14.0 \
  && echo "*** Cleaning up build dependencies ***" \
  && apt-get -y autoremove \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

USER $USER

RUN \
  echo "*** Setting up development environment ***" \
  && sudo chown -R $USER:$USER /app /config /defaults \
  && echo "*** Setting up development environment ***" \
  && git clone https://github.com/99linesofcode/dotfiles.git $HOME/dotfiles \
  && $HOME/dotfiles/install.sh
