# Docker Development container

You stumbled upon my personal PHP/Laravel development and production containers meant to be used by those who for some reason cannot depend on Laravel Sail or Valet.

Additionally this repository can be used as a starting point for a single server setup OR easily expanded upon for the more complicated projects. It deploys your production code ontop of Linuxserver.io's Secure Web Application Gateway containers built on Linux Alpine and bundled with `s6-overlay`, `certbot` and `fail2ban`.

## Starting and Stopping your containers

The project is configured with sensible defaults for development and can be spun up by running `docker-compose up -d` inside whatever directory your `docker-compose .yml` files live. By default PHP will be served from port `80`. use `docker-compose down` to stop all running containers.

## Laravel environment configuration

Your application now lives inside a Docker container which means that, inside Laravel's environment file you will need to point your `MYSQL_HOST`, `REDIS_HOST`, `MAIL_PORT` variables to your container DNS names which Docker will resolve to the correct network IP address:

```
DB_HOST=linesofcode.mysql
REDIS_HOST=linesofcode.redis
MAIL_HOST=linesofcode.mailhog
```

## XDebug

XDebug3 comes pre-installed in development and listens on the default port `9003`. It can be enabled and disabled by setting the `FLY_XDEBUG_MODE` variable as can be see in the `.env.example` file.

## SSH agent forwarding

Your `$SSH_AGENT` is automatically volume mounted into the container enabling you to use `composer --no-interaction` and SSH keys inside the container.

## Logging in and running PHP commands

Use `docker-compose exec app bash` to login to the `app` container where you will find that your files live in the `/config/www` directory. Artisan and Composer can be run from the `/config/www/api`'s root directory.

## Volume mounting config/

All of the files that are used to configure these containers will be volume mounted to  your `$HOME` directory under `./config/<$REPOSITORY>`. This is also where your database files and logs can be found. As is Linuxserver.io convention. For more information see their documentation: <https://docs.linuxserver.io/general/running-our-containers#the-config-volume>

## Contributing to docker-base

We love your input and want to make contributing to this project as easy and transparent as possible, whether it's:

- Reporting a bug
- Discussing the current state of the code
- Submitting a fix
- Proposing new features
- Becoming a maintainer

### We Develop with Github

We use Github to host code, to track and plan issues and feature requests, as well as accept pull requests.

### We Use [Github Flow](https://docs.github.com/en/get-started/quickstart/github-flow), So All Code Changes Happen Through Pull Requests

Pull requests are the best way to propose changes to the codebase (we use [Github Flow](https://docs.github.com/en/get-started/quickstart/github-flow)). We actively welcome your pull requests:

1. Fork the repo and create your branch from `master`.
2. If you've added code that should be tested, add tests.
3. If you've changed APIs, update the documentation.
4. Ensure the test suite passes.
5. Make sure your code lints.
6. Issue that pull request!

## License

Copyright (c) 99linesofcode. All rights reserved.

Licensed under the [GPL](LICENSE) license in accordance with the [linuxserver.io](https://linuxserver.io) license requirements.

By contributing, you agree that your contributions will be licensed under the GPL License.
