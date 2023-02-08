# syntax=docker/dockerfile:1

FROM ubuntu:22.04

LABEL maintainer="Jordy Schreuders <jordy@schreuders.it>"

ARG DEBIAN_FRONTEND=noninteractive
ARG VIM_DEPS="ninja-build gettext libtool libtool-bin autoconf automake cmake g++ pkg-config unzip doxygen"
ARG USER=abc
ARG PUID=1000
ARG PGID=1000

ENV TZ=UTC
ENV PHP_VERSION=8.1
ENV PS1="$(whoami)@$(hostname):$(pwd)\\$ "

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
  fzf \
  ripgrep \
  zsh \
  nodejs \
  && echo "*** Setup container user ***" \
  && useradd -u $PUID -U -d /config -s /bin/bash -G users $USER \
  && echo "abc ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers.d/$USER \
  && chmod 0440 /etc/sudoers.d/$USER

RUN \
  echo "*** Set up PHP and Composer ***" \
  && mkdir -p $HOME/.gnupg \
  && chmod 600 $HOME/.gnupg \
  && echo "disable-ipv6" >> $HOME/.gnupg/dirmngr.conf \
  && echo "keyserver hkp://keyserver.ubuntu.com:80" >> $HOME/.gnupg/dirmngr.conf \
  && gpg --recv-key 0x14aa40ec0831756756d7f66c4f4ea0aae5267a6c \
  && gpg --export 0x14aa40ec0831756756d7f66c4f4ea0aae5267a6c >> /usr/share/keyrings/ppa_ondrej_php.gpg \
  && echo "deb [signed-by=/usr/share/keyrings/ppa_ondrej_php.gpg] https://ppa.launchpadcontent.net/ondrej/php/ubuntu jammy main" >> /etc/apt/sources.list.d/ppa_ondrej_php.list \
  && apt-get update && apt-get install -y --no-install-recommends $PHP_DEPS \
  php$PHP_VERSION-cli \
  && php -r "readfile('https://getcomposer.org/installer');" | php -- --install-dir=/usr/local/bin --filename=composer

# TODO setup neovim and possibly extract to dedicted container
# RUN \
#   echo "*** Building and configuring Neovim ***" \
#   && git clone https://github.com/neovim/neovim \
#   && cd neovim \
#   && make CMAKE_BUILD_TYPE=Release \
#   && make CMAKE_INSTALL_PREFIX=$HOME/.local/bin/nvim install \
#   && ln -s $HOME/.local/bin/nvim $HOME/.local/bin/vim \
#   && rm -rf $HOME/neovim

# TODO reconsider how to setup and configure the development environment
# RUN --mount=type=ssh \
#   echo "*** Setting up development environment ***" \
#   # Oh My Zsh
#   && sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" \
#   && rm $HOME/.zshrc \
#   # SSH
#   && mkdir $HOME/.ssh \
#   && ssh-keyscan github.com >> $HOME/.ssh/known_hosts \
#   # Dotfiles
#   && git clone git@github.com:99linesofcode/dotfiles.git $HOME/.config/dotfiles \
#   && ln -s $HOME/.config/dotfiles/.zshrc .zshrc \
#   && ln -s $HOME/.config/dotfiles/.gitconfig .gitconfig \
#   && ln -s $HOME/.config/dotfiles/.gitignore .gitignore \
#   && ln -s $HOME/.config/dotfiles/.gitignore_global .gitignore_global \
#   && ln -s $HOME/.config/dotfiles/.config .config

RUN \
  echo "*** Installing BTTR dependencies ***" \
  && apt-get install -y --no-install-recommends \
  mysql-client \
  libjpeg-turbo8-dev \
  libjpeg-turbo-progs \
  libxslt1-dev \
  imagemagick \
  optipng \
  gifsicle \
  graphviz \
  php$PHP_VERSION-imagick \
  php$PHP_VERSION-xsl

RUN \
  echo "*** Cleaning up build dependencies ***" \
  apt-get -y remove $PHP_DEPS $VIM_DEPS \
  && apt-get -y autoremove \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

USER $USER

RUN \
  echo "*** Setting up user environment ***" \
  && sudo mkdir -p /app /defaults /config/.local/bin \
  && sudo chown -R $USER:$USER /app /config /defaults \
  && export PATH="$HOME/.local/bin:$PATH"

VOLUME /app /config /defaults
