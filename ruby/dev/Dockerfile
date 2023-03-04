# syntax=docker/dockerfile:1

ARG RUBY_VERSION="3.2.1"
ARG ALPINE_VERSION="3.17"
ARG BASE_IMAGE="ruby:${RUBY_VERSION}-alpine${ALPINE_VERSION}"

FROM ${BASE_IMAGE}

LABEL maintainer="Jordy Schreuders <jordy@schreuders.it>"

RUN \
  echo "*** Installing runtime packages ***" \
  && apk add --no-cache --upgrade --virtual build-dependencies build-base \
  mariadb-dev
