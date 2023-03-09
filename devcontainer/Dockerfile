# syntax=docker/dockerfile:1

ARG OS_VERSION="22.04"
ARG BASE_IMAGE="ubuntu:${OS_VERSION}"

FROM ${BASE_IMAGE}

LABEL maintainer="Jordy Schreuders <jordy@schreuders.it>"

ARG DEBIAN_FRONTEND=noninteractive
ARG NEOVIM_VERSION="nightly"
ARG PGID=1000
ARG PUID=1000
ARG TZ="Europe/Amsterdam"
ARG USER=abc

WORKDIR /app

SHELL ["/bin/sh", "-c"]

RUN \
  echo "*** Set locale and timezone ***" \
  && echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen && locale-gen \
  && ln -snf /usr/share/zoneinfo/${TZ} /etc/localtime && echo ${TZ} >> /etc/timezone \
  && echo "*** Install core dependencies ***" \
  && apt-get update && apt-get install -y --no-install-recommends \
  locales \
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
  && echo "*** Creating abc user ***" \
  && useradd -u ${PUID} -U -d /config -s $(which zsh) -G users ${USER} \
  && echo "abc ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers.d/${USER} \
  && chmod 0440 /etc/sudoers.d/${USER} \
  && mkdir -p /app /config/.local/bin /defaults \
  && echo "*** Cleaning up build dependencies ***" \
  && apt-get -y autoremove \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

USER ${USER}

SHELL ["/bin/zsh", "-c"]

RUN \
  echo "*** Setting up development environment ***" \
  && sudo chown -R ${USER}:${USER} /app /config \
  && echo "*** Setting up Asdf ***" \
  && git clone https://github.com/asdf-vm/asdf.git /config/.asdf \
  && source /config/.asdf/asdf.sh \
  && asdf plugin add neovim https://github.com/richin13/asdf-neovim.git \
  && asdf plugin add nodejs https://github.com/asdf-vm/asdf-nodejs.git \
  && echo "*** Installing neovim ***" \
  && asdf install neovim $NEOVIM_VERSION \
  && asdf global neovim $NEOVIM_VERSION \
  && ln -sf /config/.asdf/shims/nvim /config/.local/bin/vim \
  && echo "*** Installing dotfiles ***" \
  && git clone https://github.com/99linesofcode/dotfiles.git $HOME/dotfiles \
  && $HOME/dotfiles/install.sh
