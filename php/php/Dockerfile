# syntax=docker/dockerfile:1

FROM ghcr.io/linuxserver/baseimage-alpine-nginx:3.16

LABEL maintainer="Jordy Schreuders <jordy@schreuders.it>"

# https://github.com/just-containers/s6-overlay#customizing-s6-behaviour
ENV S6_BEHAVIOUR_IF_STAGE2_FAILS=2
ENV PHP_VERSION="php81"

RUN \
  echo "*** Installing runtime packages ***" && \
  apk add --no-cache --upgrade \
  $PHP_VERSION-ctype \
  $PHP_VERSION-curl \
  $PHP_VERSION-intl \
  $PHP_VERSION-pdo_pgsql \
  $PHP_VERSION-pdo_sqlite \
  $PHP_VERSION-pdo_mysql \
  $PHP_VERSION-tokenizer \
  $PHP_VERSION-zip \
  $PHP_VERSION-pecl-xdebug \
  && echo "*** Installing Laravel specific runtime packages ***" && \
  apk add --no-cache --upgrade \
  $PHP_VERSION-bcmath \
  $PHP_VERSION-dom \
  $PHP_VERSION-pecl-redis \
  && echo "*** Note: These are already installed by upstream ***" && \
  apk add --no-cache --upgrade \
  $PHP_VERSION-fileinfo \
  $PHP_VERSION-mbstring \
  $PHP_VERSION-openssl \
  $PHP_VERSION-xml
