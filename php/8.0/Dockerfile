# syntax=docker/dockerfile:1

FROM ghcr.io/linuxserver/baseimage-alpine-nginx:3.16

LABEL maintainer="Jordy Schreuders <jordy@schreuders.it>"

# https://github.com/just-containers/s6-overlay#customizing-s6-behaviour
ENV S6_BEHAVIOUR_IF_STAGE2_FAILS=2

RUN \
  echo "*** Installing runtime packages ***" && \
  apk add --no-cache --upgrade \
  php8-ctype \
  php8-curl \
  php8-intl \
  php8-pdo_pgsql \
  php8-pdo_sqlite \
  php8-pdo_mysql \
  php8-tokenizer \
  php8-zip \
  php8-pecl-xdebug \
  composer \
  && echo "*** Installing Laravel specific runtime packages ***" && \
  apk add --no-cache --upgrade \
  php8-bcmath \
  php8-dom \
  php8-pecl-redis \
  && echo "*** Note: These are already installed of upstream ***" && \
  apk add --no-cache --upgrade \
  php8-fileinfo \
  php8-mbstring \
  php8-openssl \
  php8-xml

RUN \
  echo "*** Installing BTTR dependencies ***" && \
  apk add --no-cache --upgrade \
  mariadb-client \
  mariadb-connector-c \
  libjpeg-turbo-utils \
  optipng \
  gifsicle \
  php8-calendar \
  php8-exif \
  php8-gd \
  php8-soap \
  php8-xsl \
  php8-pcntl \
  php8-sodium \
  php8-xmlreader \
  php8-pecl-imagick

COPY root/ /

EXPOSE 80 443

VOLUME /app
