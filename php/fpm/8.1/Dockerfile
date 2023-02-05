# syntax=docker/dockerfile:1

FROM ghcr.io/linuxserver/baseimage-alpine-nginx:3.17

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
  php81-zip;

COPY root/ /

EXPOSE 80 443

VOLUME /config
