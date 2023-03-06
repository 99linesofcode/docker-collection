
# syntax=docker/dockerfile:1

ARG OS_VERSION="3.17"
ARG PHP_VERSION="8.1"
ARG BASE_IMAGE="ghcr.io/linuxserver/baseimage-alpine-nginx:${OS_VERSION}"

FROM ${BASE_IMAGE}

LABEL org.opencontainers.image.authors="99linesofcode@gmail.com"

# See https://docs.docker.com/engine/reference/builder/#understand-how-arg-and-from-interact
ARG PHP_VERSION

# See https://github.com/just-containers/s6-overlay#customizing-s6-behaviour
ENV S6_BEHAVIOUR_IF_STAGE2_FAILS=2

RUN \
  export PHP_VERSION="$(echo ${PHP_VERSION} | sed 's/\.//')" \
  && echo "*** Installing runtime packages ***" \
  && apk add --no-cache --upgrade \
  php${PHP_VERSION}-ctype \
  php${PHP_VERSION}-curl \
  php${PHP_VERSION}-dom \
  php${PHP_VERSION}-intl \
  php${PHP_VERSION}-pdo_pgsql \
  php${PHP_VERSION}-pdo_sqlite \
  php${PHP_VERSION}-pdo_mysql \
  php${PHP_VERSION}-tokenizer \
  php${PHP_VERSION}-zip \
  php${PHP_VERSION}-pecl-redis \
  && echo "*** Note: These are already installed upstream ***" \
  && apk add --no-cache --upgrade \
  php${PHP_VERSION}-fileinfo \
  php${PHP_VERSION}-mbstring \
  php${PHP_VERSION}-openssl \
  php${PHP_VERSION}-xml

COPY root/ /
