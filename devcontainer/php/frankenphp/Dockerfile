# syntax=docker/dockerfile:1

ARG PACKAGE_VERSION="1.1.0"
ARG BASE_IMAGE="dunglas/frankenphp:${PACKAGE_VERSION}"

FROM "${BASE_IMAGE}-builder" AS builder

COPY --from=caddy:builder /usr/bin/xcaddy /usr/bin/xcaddy

# CGO must be enabled to build FrankenPHP
ENV CGO_ENABLED=1 \
    XCADDY_SETCAP=1 \
    XCADDY_GO_BUILD_FLAGS="-ldflags='-w -s' -tags=nobadger,nomysql,nopgx"

RUN set -eux; \
  xcaddy build \
  --output /usr/local/bin/frankenphp \
  --with github.com/dunglas/frankenphp=./ \
  --with github.com/dunglas/frankenphp/caddy=./caddy/;

FROM ${BASE_IMAGE} AS runner

WORKDIR /app

RUN set -eux; \
  install-php-extensions \
  @composer \
  intl \
  pdo_mysql \
  zip \
  && pecl install redis \
  && docker-php-ext-enable redis \
  && cp $PHP_INI_DIR/php.ini-production $PHP_INI_DIR/php.ini;

# Replace the official binary by the one containing our custom modules
COPY --from=builder /usr/local/bin/frankenphp /usr/local/bin/frankenphp
COPY --link ./Caddyfile /etc/caddy/Caddyfile
COPY --link --chmod=755 ./docker-php-entrypoint.sh /usr/local/bin/docker-php-entrypoint

COPY ../ ./

RUN set -eux; \
  composer install -n --no-cache --prefer-dist --no-dev --no-scripts -o -a

ENTRYPOINT ["docker-php-entrypoint"]

CMD ["frankenphp", "run", "--config", "/etc/caddy/Caddyfile"]
