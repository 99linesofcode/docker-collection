FROM php:8.1-rc-fpm-alpine

LABEL maintainer="Jordy Schreuders"

RUN apk update && apk add --no-cache --virtual .build-deps \
  $PHPIZE_DEPS \
  curl-dev \
  postgresql-dev \
  sqlite-dev \
  libxml2-dev \
  linux-headers \
  # Install dependencies
  && apk add \
  curl \
  oniguruma-dev \
  postgresql-libs \
  # Install PECL and PEAR extensions
  && pecl install \
  redis \
  xdebug \
  # Enable PECL and PEAR extensions
  && docker-php-ext-enable \
  redis \
  xdebug \
  # Configure PHP extensions
  # && docker-php-ext-configure gd --with-freetype --with-jpeg \
  # Install PHP extensions
  && docker-php-ext-install \
  bcmath \
  curl \
  mbstring \
  pdo \
  pdo_pgsql \
  pdo_sqlite \
  xml \
  # Cleanup build dependencies
  && apk del -f .build-deps
