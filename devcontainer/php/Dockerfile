# syntax=docker/dockerfile:1

ARG PACKAGE_VERSION="ubuntu22.04"
ARG BASE_IMAGE="ghcr.io/99linesofcode/devcontainer:${PACKAGE_VERSION}"

FROM ${BASE_IMAGE}

LABEL org.opencontainers.image.authors="99linesofcode@gmail.com"

ARG DEBIAN_FRONTEND=noninteractive
ARG NODE_VERSION="18.14.0"
# See https://docs.docker.com/engine/reference/builder/#understand-how-arg-and-from-interact
ARG PHP_VERSION="8.1"
ARG TZ="Europe/Amsterdam"
ARG USER=abc

WORKDIR /app

USER root

RUN \
  echo "*** Override timezone information ***" \
  && ln -snf /usr/share/zoneinfo/${TZ} /etc/localtime && echo ${TZ} >> /etc/timezone \
  && echo "*** Installing PHP ***" \
  && curl -sS 'https://keyserver.ubuntu.com/pks/lookup?op=get&search=0x14aa40ec0831756756d7f66c4f4ea0aae5267a6c' | gpg --dearmor | tee /usr/share/keyrings/ppa_ondrej_php.gpg > /dev/null \
  && echo "deb [signed-by=/usr/share/keyrings/ppa_ondrej_php.gpg] https://ppa.launchpadcontent.net/ondrej/php/ubuntu jammy main" >> /etc/apt/sources.list.d/ppa_ondrej_php.list \
  && apt-get update && apt-get install -y --no-install-recommends \
  php${PHP_VERSION}-bcmath \
  php${PHP_VERSION}-cli \
  php${PHP_VERSION}-dev \
  php${PHP_VERSION}-curl \
  php${PHP_VERSION}-gd \
  php${PHP_VERSION}-igbinary \
  php${PHP_VERSION}-imagick \
  php${PHP_VERSION}-imap \
  php${PHP_VERSION}-intl \
  php${PHP_VERSION}-ldap \
  php${PHP_VERSION}-mbstring \
  php${PHP_VERSION}-memcached \
  php${PHP_VERSION}-msgpack \
  php${PHP_VERSION}-mysql \
  php${PHP_VERSION}-pcov \
  php${PHP_VERSION}-pgsql \
  php${PHP_VERSION}-readline \
  php${PHP_VERSION}-redis \
  php${PHP_VERSION}-soap \
  php${PHP_VERSION}-sqlite3 \
  php${PHP_VERSION}-swoole \
  php${PHP_VERSION}-xml \
  php${PHP_VERSION}-xdebug \
  php${PHP_VERSION}-zip \
  && echo "*** Cleaning up build dependencies ***" \
  && apt-get -y autoremove \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

USER $USER

RUN \
  echo "*** Installing Composer to $HOME/.local/bin ***" \
  && php -r "readfile('https://getcomposer.org/installer');" | php -- --install-dir=/config/.local/bin --filename=composer \
  && echo "*** Installing Node.js ***" \
  && ASDF_DIR="${HOME}/.asdf" . /config/.asdf/asdf.sh \
  && asdf plugin add nodejs https://github.com/asdf-vm/asdf-nodejs.git \
  && asdf install nodejs ${NODE_VERSION} \
  && asdf global nodejs ${NODE_VERSION}
