
# syntax=docker/dockerfile:1

ARG OS_VERSION="3.17"
ARG PACKAGE_VERSION="8.1"
ARG BASE_IMAGE="ghcr.io/linuxserver/baseimage-alpine-nginx:${OS_VERSION}"

FROM ${BASE_IMAGE}

LABEL org.opencontainers.image.authors="99linesofcode@gmail.com"

# See https://docs.docker.com/engine/reference/builder/#understand-how-arg-and-from-interact
ARG PACKAGE_VERSION

# See https://github.com/just-containers/s6-overlay#customizing-s6-behaviour
ENV S6_BEHAVIOUR_IF_STAGE2_FAILS=2

RUN \
  export PACKAGE_VERSION="$(echo ${PACKAGE_VERSION} | sed 's/\.//')" \
  && echo "*** Installing runtime packages ***" \
  && apk add --no-cache --upgrade \
  php${PACKAGE_VERSION}-ctype \
  php${PACKAGE_VERSION}-curl \
  php${PACKAGE_VERSION}-intl \
  php${PACKAGE_VERSION}-pdo_pgsql \
  php${PACKAGE_VERSION}-pdo_sqlite \
  php${PACKAGE_VERSION}-pdo_mysql \
  php${PACKAGE_VERSION}-tokenizer \
  php${PACKAGE_VERSION}-zip \
  && echo "*** Installing Laravel specific runtime packages ***" \
  && apk add --no-cache --upgrade \
  php${PACKAGE_VERSION}-bcmath \
  php${PACKAGE_VERSION}-dom \
  php${PACKAGE_VERSION}-pecl-redis \
  && echo "*** Note: These are already installed upstream ***" \
  && apk add --no-cache --upgrade \
  php${PACKAGE_VERSION}-fileinfo \
  php${PACKAGE_VERSION}-mbstring \
  php${PACKAGE_VERSION}-openssl \
  php${PACKAGE_VERSION}-xml

COPY root/ /
