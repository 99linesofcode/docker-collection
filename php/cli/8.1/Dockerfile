# syntax=docker/dockerfile:1

FROM php:8.1-cli-alpine

LABEL maintainer="Jordy Schreuders <jordy@schreuders.it>"

RUN \
  apk add --no-cache --virtual .build-deps \
  $PHPIZE_DEPS \
  curl-dev \
  postgresql-dev \
  sqlite-dev \
  libxml2-dev \
  linux-headers \
  && echo "*** Installing dependencies ***" && \
  apk add \
  curl \
  oniguruma-dev \
  postgresql-libs \
  && echo "*** Installing PECL and PEAR extensions ***"  &&\
  pecl install \
  redis \
  xdebug \
  && echo "*** Enabling PECL and PEAR extensions ***" && \
  docker-php-ext-enable \
  redis \
  xdebug \
  # && echo "*** Configure PHP extensions ***" && \
  # docker-php-ext-configure gd --with-freetype --with-jpeg \
  && echo "*** Installing PHP extensions ***" && \
  docker-php-ext-install \
  bcmath \
  curl \
  mbstring \
  pdo \
  pdo_pgsql \
  pdo_sqlite \
  xml \
  && echo "*** Cleaning up build dependencies ***" && \
  apk del -f .build-deps

EXPOSE 80 443
