# syntax=docker/dockerfile:1

ARG PACKAGE_VERSION="latest"

FROM ghcr.io/99linesofcode/devcontainer:$PACKAGE_VERSION

LABEL maintainer="Jordy Schreuders <jordy@schreuders.it>"

ARG DEBIAN_FRONTEND=noninteractive
ARG PHP_VERSION="8.1"
# ARG BUILD_DEPS="autoconf bison gettext libgd-dev libcurl4-openssl-dev libedit-dev libicu-dev libjpeg-dev libmysqlclient-dev libonig-dev libpng-dev libpq-dev libreadline-dev libsqlite3-dev libssl-dev libxml2-dev libzip-dev openssl pkg-config re2c zlib1g-dev"

SHELL ["/bin/bash", "-c"]

RUN \
  # TODO swap to asdf install once issues with the plugin have been resolved
  echo "*** Set up PHP and Composer ***" \
  && mkdir -p $HOME/.gnupg \
  && chmod 600 $HOME/.gnupg \
  && echo "disable-ipv6" >> $HOME/.gnupg/dirmngr.conf \
  && echo "keyserver hkp://keyserver.ubuntu.com:80" >> $HOME/.gnupg/dirmngr.conf \
  && gpg --recv-key 0x14aa40ec0831756756d7f66c4f4ea0aae5267a6c \
  && gpg --export 0x14aa40ec0831756756d7f66c4f4ea0aae5267a6c >> /usr/share/keyrings/ppa_ondrej_php.gpg \
  && echo "deb [signed-by=/usr/share/keyrings/ppa_ondrej_php.gpg] https://ppa.launchpadcontent.net/ondrej/php/ubuntu jammy main" >> /etc/apt/sources.list.d/ppa_ondrej_php.list \
  && apt-get update && apt-get install -y --no-install-recommends \
  php$PHP_VERSION-cli \
  && php -r "readfile('https://getcomposer.org/installer');" | php -- --install-dir=/usr/local/bin --filename=composer

# && echo "*** Install PHP through ASDF ***" \
# && apt-get update && apt-get install -y --no-install-recommends \
# $BUILD_DEPS \
# && source /config/.asdf/asdf.sh \
# && asdf plugin-add php https://github.com/asdf-community/asdf-php.git \
# && asdf install php PHP_VERSION \
# && echo "*** Cleaning up build dependencies ***" \
# && apt-get -y remove $BUILD_DEPS \
# && apt-get -y autoremove \
# && apt-get clean \
# && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

USER $USER

RUN \
  echo "*** Setting up user environment ***" \
  && sudo chown -R $USER:$USER /app /config /defaults \
  # TODO this can probably be handled in .zshrc later on
  && export PATH="$HOME/.local/bin:$PATH"
