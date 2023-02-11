# syntax=docker/dockerfile:1

FROM ubuntu:22.04

LABEL maintainer="Jordy Schreuders <jordy@schreuders.it>"

ARG DEBIAN_FRONTEND=noninteractive
ARG USER=abc
ARG PUID=1000
ARG PGID=1000
ARG VIM_DEPS="ninja-build gettext libtool libtool-bin autoconf automake cmake g++ pkg-config unzip doxygen"

ENV TZ=UTC

RUN \
  ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ >> /etc/timezone \
  && echo "*** Install base dependencies ***" \
  apt-get update && apt-get install -y --no-install-recommends \
  $VIM_DEPS \
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
  && echo "*** Setup container user ***" \
  && useradd -u $PUID -U -d /config -s /bin/zsh -G users $USER \
  && echo "abc ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers.d/$USER \
  && chmod 0440 /etc/sudoers.d/$USER \
  && echo "*** Build Neovim from source ***" \
  && cd /config \
  && git clone https://github.com/neovim/neovim \
  && cd neovim \
  && make CMAKE_BUILD_TYPE=Release \
  && make CMAKE_INSTALL_PREFIX=/config/.local/bin/nvim install \
  && ln -s /config/.local/bin/nvim /config/.local/bin/vim \
  && rm -rf /config/neovim

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
