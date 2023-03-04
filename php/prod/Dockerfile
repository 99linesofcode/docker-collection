# syntax=docker/dockerfile:1

ARG ALPINE_VERSION="3.17"
ARG BASE_IMAGE="php:fpm-alpine${ALPINE_VERSION}"

FROM ${BASE_IMAGE}

LABEL maintainer="Jordy Schreuders <jordy@schreuders.it>"

ARG PHP_VERSION="8.1"
ARG PHP_VERSION=${PHP_VERSION//./}

RUN \
  echo "*** Installing runtime packages ***" && \
  apk add --no-cache --upgrade \
  PHP${PHP_VERSION}-pecl-redis
