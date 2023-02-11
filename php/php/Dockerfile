# syntax=docker/dockerfile:1

FROM ghcr.io/linuxserver/baseimage-alpine-nginx:3.17

LABEL maintainer="Jordy Schreuders <jordy@schreuders.it>"

# https://github.com/just-containers/s6-overlay#customizing-s6-behaviour
ENV S6_BEHAVIOUR_IF_STAGE2_FAILS=2
ENV PHP_VERSION="81"

RUN \
  echo "*** Installing runtime packages ***" && \
  apk add --no-cache --upgrade \
  php$PHP_VERSION-ctype \
  php$PHP_VERSION-curl \
  php$PHP_VERSION-intl \
  php$PHP_VERSION-pdo_pgsql \
  php$PHP_VERSION-pdo_sqlite \
  php$PHP_VERSION-pdo_mysql \
  php$PHP_VERSION-tokenizer \
  php$PHP_VERSION-zip \
  php$PHP_VERSION-pecl-xdebug \
  && echo "*** Installing Laravel specific runtime packages ***" && \
  apk add --no-cache --upgrade \
  php$PHP_VERSION-bcmath \
  php$PHP_VERSION-dom \
  php$PHP_VERSION-pecl-redis \
  && echo "*** Note: These are already installed by upstream ***" && \
  apk add --no-cache --upgrade \
  php$PHP_VERSION-fileinfo \
  php$PHP_VERSION-mbstring \
  php$PHP_VERSION-openssl \
  php$PHP_VERSION-xml
