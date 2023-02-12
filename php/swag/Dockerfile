# syntax=docker/dockerfile:1

ARG PACKAGE_VERSION="latest"

FROM ghcr.io/linuxserver/swag:$PACKAGE_VERSION

LABEL maintainer="Jordy Schreuders <jordy@schreuders.it>"

# https://github.com/just-containers/s6-overlay#customizing-s6-behaviour
ENV S6_BEHAVIOUR_IF_STAGE2_FAILS=2
