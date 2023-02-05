# syntax=docker/dockerfile:1

FROM php:8.1-cli-alpine

LABEL maintainer="Jordy Schreuders <jordy@schreuders.it>"

RUN apk update && apk add --no-cache --virtual .build-deps \
  $PHPIZE_DEPS \
  curl-dev \
  postgresql-dev \
  sqlite-dev \
  libxml2-dev \
  linux-headers \
  && echo "*** Install dependencies ***" \
  && apk add \
  curl \
  oniguruma-dev \
  postgresql-libs \
  && echo "*** Install PECL and PEAR extensions ***" \
  && pecl install \
  redis \
  xdebug \
  && echo "*** Enable PECL and PEAR extensions ***" \
  && docker-php-ext-enable \
  redis \
  xdebug \
  && echo "*** Configure PHP extensions ***" \
  # && docker-php-ext-configure gd --with-freetype --with-jpeg \
  && echo "*** Install PHP extensions ***" \
  && docker-php-ext-install \
  bcmath \
  curl \
  mbstring \
  pdo \
  pdo_pgsql \
  pdo_sqlite \
  xml \
  && echo "*** Cleanup build dependencies ***" \
  && apk del -f .build-deps
