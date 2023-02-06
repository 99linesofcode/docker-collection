# syntax=docker/dockerfile:1

FROM ubuntu:22.04

LABEL maintainer="Jordy Schreuders <jordy@schreuders.it>"

ARG DEBIAN_FRONTEND=noninteractive
ARG PHP_DEPS="gnupg software-properties-common ca-certificates lsb-release apt-transport-https"
ARG VIM_DEPS="ninja-build gettext libtool libtool-bin autoconf automake cmake g++ pkg-config unzip doxygen"
ARG PUID=1000
ARG PGID=1000
ARG HOME=/config
ARG SUDO=docker

ENV TZ=UTC

WORKDIR $HOME

RUN \
  echo "*** Setup timezone ***" && \
  ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone \
  echo "*** Installing base dependencies ***" && \
  apt-get update && apt-get install -y --no-install-recommends $PHP_DEPS $VIM_DEPS \
  sudo \
  build-essential \
  ssh \
  curl \
  fzf \
  ripgrep \
  zsh \
  git \
  nodejs

# TODO what to do with nodejs dependency? Maybe leave it in global devcontainer
# TODO extract base image and dedicated PHP containers

RUN \
  echo "*** Building and configuring Neovim ***" \
  && git clone https://github.com/neovim/neovim \
  && cd neovim \
  && sudo make CMAKE_BUILD_TYPE=Release \
  && sudo make CMAKE_INSTALL_PREFIX=$HOME/.local/bin/nvim install \
  && ln -s $HOME/.local/bin/nvim $HOME/.local/bin/vim \
  && rm -rf $HOME/neovim

RUN \
  echo "*** Setting up PHP and Composer ***" \
  && mkdir -p $HOME/.gnupg \
  && chmod 600 $HOME/.gnupg \
  && echo "disable-ipv6" >> $HOME/.gnupg/dirmngr.conf \
  && echo "keyserver hkp://keyserver.ubuntu.com:80" >> $HOME/.gnupg/dirmngr.conf \
  && gpg --recv-key 0x14aa40ec0831756756d7f66c4f4ea0aae5267a6c \
  && gpg --export 0x14aa40ec0831756756d7f66c4f4ea0aae5267a6c > /usr/share/keyrings/ppa_ondrej_php.gpg \
  && echo "deb [signed-by=/usr/share/keyrings/ppa_ondrej_php.gpg] https://ppa.launchpadcontent.net/ondrej/php/ubuntu jammy main" > /etc/apt/sources.list.d/ppa_ondrej_php.list \
  && apt-get update \
  && apt-get install -y --no-install-recommends php8.1-cli \
  && php -r "readfile('https://getcomposer.org/installer');" | php -- --install-dir=/usr/local/bin --filename=composer

RUN \
  echo "*** Cleaning up build dependencies ***" \
  apt-get -y remove $PHP_DEPS $VIM_DEPS \
  && apt-get -y autoremove \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN --mount=type=ssh \
  echo "*** Setting up development environment ***" \
  # Oh My Zsh
  && sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" \
  && rm $HOME/.zshrc \
  # SSH
  && mkdir $HOME/.ssh \
  && ssh-keyscan github.com >> $HOME/.ssh/known_hosts \
  # Dotfiles
  && git clone git@github.com:99linesofcode/dotfiles.git $HOME/.config/dotfiles \
  && ln -s $HOME/.config/dotfiles/.zshrc .zshrc \
  && ln -s $HOME/.config/dotfiles/.gitconfig .gitconfig \
  && ln -s $HOME/.config/dotfiles/.gitignore .gitignore \
  && ln -s $HOME/.config/dotfiles/.gitignore_global .gitignore_global \
  && ln -s $HOME/.config/dotfiles/.config .config
