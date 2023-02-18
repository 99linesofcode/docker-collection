# syntax=docker/dockerfile:1

ARG PACKAGE_VERSION=alpine

FROM ruby:$PACKAGE_VERSION

LABEL maintainer="Jordy Schreuders <jordy@schreuders.it>"

COPY Gemfile Gemfile.lock ./

RUN \
  echo "*** Installing runtime packages ***" && \
  apk add --no-cache --upgrade --virtual build-dependencies build-base \
  mariadb-dev \
  && echo "*** Configure bundler to throw errors if Gemfile was modified ***" \
  && bundle config --global frozen 1 \
  && bundle install
