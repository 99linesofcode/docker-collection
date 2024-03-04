# syntax=docker/dockerfile:1

ARG OS_VERSION="22.04"
ARG BASE_IMAGE="ubuntu:${OS_VERSION}"

FROM ${BASE_IMAGE}

LABEL maintainer="Jordy Schreuders <jordy@schreuders.it>"

ARG DEBIAN_FRONTEND=noninteractive
ARG ZOXIDE_VERSION="0.9.4"
ARG PUID=1000
ARG PGID=1000
ARG TZ="Europe/Amsterdam"
ARG USER=abc

WORKDIR /app

RUN \
  echo "*** Installing core dependencies ***" \
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
  less \
  zip \
  unzip \
  git \
  fzf \
  ripgrep \
  zsh \
  neofetch \
  && echo "*** Setting locale and timezone information ***" \
  && echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen && locale-gen \
  && ln -snf /usr/share/zoneinfo/${TZ} /etc/localtime \
  && echo ${TZ} >> /etc/timezone \
  && echo "*** Creating user and directories ***" \
  && useradd -u ${PUID} -U -d /config -s $(which zsh) -G users ${USER} \
  && echo "abc ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers.d/${USER} \
  && chmod 0440 /etc/sudoers.d/${USER} \
  && mkdir -p /app /config/.local/bin /defaults \
  && chown -R ${USER}:${USER} /app /config /defaults \
  && echo "*** Cleaning up build dependencies ***" \
  && apt-get -y autoremove \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

USER ${USER}

RUN \
  echo "*** Setting up Asdf ***" \
  && git clone https://github.com/asdf-vm/asdf.git /config/.asdf \
  && echo "*** Installing zoxide ***" \
  && ASDF_DIR="${HOME}/.asdf" . /config/.asdf/asdf.sh \
  && asdf plugin add zoxide https://github.com/nyrst/asdf-zoxide.git \
  && asdf install zoxide ${ZOXIDE_VERSION} \
  && asdf global zoxide ${ZOXIDE_VERSION}
