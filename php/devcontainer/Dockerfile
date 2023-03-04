# syntax=docker/dockerfile:1

ARG VERSION="8.1"
ARG BASE_IMAGE="ghcr.io/99linesofcode/devcontainer:${VERSION}"

FROM ${BASE_IMAGE}

LABEL maintainer="Jordy Schreuders <jordy@schreuders.it>"

ARG DEBIAN_FRONTEND=noninteractive
ARG USER=abc

SHELL ["zsh", "-c"]

USER root

RUN \
  echo "*** Installing PHP ***" \
  && mkdir -p $HOME/.gnupg \
  && chmod 600 $HOME/.gnupg \
  && echo "disable-ipv6" >> $HOME/.gnupg/dirmngr.conf \
  && echo "keyserver hkp://keyserver.ubuntu.com:80" >> $HOME/.gnupg/dirmngr.conf \
  && gpg --recv-key 0x14aa40ec0831756756d7f66c4f4ea0aae5267a6c \
  && gpg --export 0x14aa40ec0831756756d7f66c4f4ea0aae5267a6c >> /usr/share/keyrings/ppa_ondrej_php.gpg \
  && echo "deb [signed-by=/usr/share/keyrings/ppa_ondrej_php.gpg] https://ppa.launchpadcontent.net/ondrej/php/ubuntu jammy main" >> /etc/apt/sources.list.d/ppa_ondrej_php.list \
  && apt-get update && apt-get install -y --no-install-recommends \
  php${VERSION}-cli

USER $USER

RUN \
  echo "*** Installing Composer to $HOME/.local/bin ***" \
  && php -r "readfile('https://getcomposer.org/installer');" | php -- --install-dir=/config/.local/bin --filename=composer
