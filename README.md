# Docker Base

As developers we tend to work with a large variety of programming languages, database engines and other accessories, that all come with their own dependencies and configuration. If you are like me, and you want to keep those packages separate from your hostmachine or are just looking for a standardized way for you and your team to work, this repository might be worth taking a look at.

Using Visual Studio Code, in combination with the Remote Development Extension and the provided `.devcontainer.json` files you are able to use the provided devcontainers as full featured development environments. While all of the configuration for your terminal, editor (extensions) and programming environment lives inside relatively straight forward `Dockerfile`s, available for you to modify and extend.

See the `RUN` commands in [devcontainer/Dockerfile](./devcontainer/Dockerfile) and the dedicated PHP and Ruby `Dockerfile`s for a list of all the packages are pre-configured and installed. I've tried to generalize as much of the configuration as possible but as it stands now, the base image is not fully configurable yet. Should you wish to use it as a starting point for your own setup, I would recommend that you create your own base image to build upon for now.

## Contributing to docker-base

We love your input and want to make contributing to this project as easy and transparent as possible, whether it's:

- Reporting a bug
- Discussing the current state of the code
- Submitting a fix
- Proposing new features
- Becoming a maintainer

### We Develop with Github

We use Github to host code, to track and plan issues and feature requests, as well as accept pull requests.

### All Code Changes Happen Through Pull Requests

Pull requests are the best way to propose changes to the codebase (we use [Github Flow](https://docs.github.com/en/get-started/quickstart/github-flow)). We actively welcome your pull requests:

1. Fork the repo and create your branch from `master`.
2. If you've added code that should be tested, add tests.
3. If you've changed APIs, update the documentation.
4. Ensure the test suite passes.
5. Make sure your code lints.
6. Issue that pull request!

## License

Copyleft (c) 99linesofcode. All rights reserved.

Licensed under the [GPL](LICENSE) license in accordance with the [linuxserver.io](https://linuxserver.io) license requirements.

By contributing, you agree that your contributions will be licensed under the GPL License.
