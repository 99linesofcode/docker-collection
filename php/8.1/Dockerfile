# syntax=docker/dockerfile:1

FROM ghcr.io/linuxserver/baseimage-alpine-nginx:3.16

LABEL maintainer="Jordy Schreuders <jordy@schreuders.it>"

# https://github.com/just-containers/s6-overlay#customizing-s6-behaviour
ENV S6_BEHAVIOUR_IF_STAGE2_FAILS=2

RUN \
  echo "*** Installing runtime packages ***" && \
  apk add --no-cache --upgrade \
  php81-ctype \
  php81-curl \
  php81-intl \
  php81-pdo_pgsql \
  php81-pdo_sqlite \
  php81-pdo_mysql \
  php81-tokenizer \
  php81-zip \
  php81-pecl-xdebug \
  composer \
  && echo "*** Installing Laravel specific runtime packages ***" && \
  apk add --no-cache --upgrade \
  php81-bcmath \
  php81-dom \
  php81-pecl-redis \
  && echo "*** Note: These are already installed of upstream ***" && \
  apk add --no-cache --upgrade \
  php81-fileinfo \
  php81-mbstring \
  php81-openssl \
  php81-xml

RUN \
  echo "*** Installing BTTR dependencies ***" && \
  apk add --no-cache --upgrade \
  mariadb-client \
  mariadb-connector-c \
  libjpeg-turbo-utils \
  optipng \
  gifsicle \
  php81-calendar \
  php81-exif \
  php81-gd \
  php81-soap \
  php81-xsl \
  php81-pcntl \
  php81-sodium \
  php81-xmlreader \
  php81-pecl-imagick

COPY root/ /

EXPOSE 80 443

VOLUME /app
