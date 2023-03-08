# syntax=docker/dockerfile:1

ARG OS_VERSION="alpine3.17"
ARG RUBY_VERSION="3.2.1"
ARG BASE_IMAGE="ruby:${RUBY_VERSION}-${OS_VERSION}"

FROM ${BASE_IMAGE}

WORKDIR /config/www

RUN \
  echo "*** Installing runtime packages ***" \
  && apk add --no-cache --upgrade --virtual build-dependencies build-base \
  mariadb-dev
