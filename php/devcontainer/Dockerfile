# syntax=docker/dockerfile:1

ARG PACKAGE_VERSION="latest"

FROM ghcr.io/99linesofcode/devcontainer:$PACKAGE_VERSION

LABEL maintainer="Jordy Schreuders <jordy@schreuders.it>"

ARG DEBIAN_FRONTEND=noninteractive
ARG USER=abc
ARG PHP_VERSION="8.1"

SHELL ["/bin/bash", "-c"]

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
  php$PHP_VERSION-bcmath \
  php$PHP_VERSION-cli \
  php$PHP_VERSION-curl \
  php$PHP_VERSION-dev \
  php$PHP_VERSION-gd \
  php$PHP_VERSION-imap \
  php$PHP_VERSION-igbinary \
  php$PHP_VERSION-intl \
  php$PHP_VERSION-ldap \
  php$PHP_VERSION-mbstring \
  php$PHP_VERSION-memcached \
  php$PHP_VERSION-msgpack \
  php$PHP_VERSION-mysql \
  php$PHP_VERSION-pcov \
  php$PHP_VERSION-pgsql \
  php$PHP_VERSION-readline \
  php$PHP_VERSION-redis \
  php$PHP_VERSION-soap \
  php$PHP_VERSION-sqlite3 \
  php$PHP_VERSION-swoole \
  php$PHP_VERSION-xml \
  php$PHP_VERSION-xdebug \
  php$PHP_VERSION-zip \
  && echo "*** Installing Composer to $HOME/.local/bin ***" \
  && php -r "readfile('https://getcomposer.org/installer');" | php -- --install-dir=/config/.local/bin --filename=composer

USER $USER
