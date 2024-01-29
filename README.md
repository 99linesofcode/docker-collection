# Docker Base

Docker Base is a collection of Docker and Docker Compose files used to quickly spin up a development container. Looking for a way to keep your project code and dependencies separate from your host machine? Want something to base your Github Codespace or Gitpod containers off of? This repository might serve as a good starting point.

## Configuration

Development dependencies can be found in the `Dockerfile` for each respective development environment. Programming language specific containers extend a base container running Ubuntu LTS. Just about everything else can be found and configured in the respective `docker-compose.yaml` files.

## Contributing to docker-base

Thank you for considering contributing to Docker Base. Please review our [Contribution Guidelines](CONTRIBUTING.md).

## Code of Conduct

In order to ensure that the community is welcoming to all, please review and abide by the [Code of Conduct](CODE_OF_CONDUCT.md).

## Security Vulnerabilities

Please review [our security policy](SECURITY.md) on how to report security vulnerabilities.

## License

Docker Base is open-sourced software licensed under the [MIT license](LICENSE)
