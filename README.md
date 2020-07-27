# Docker Base
Interested in a bare metal Docker configuration to easily and more importantly safely serve your Laravel project with? Look no further.

Docker base is build ontop of the well supported [linuxserver.io](https://linuxserver.io) images and is only minimally extended and configured to be used in both development and production environments. `docker-compose.override.yml` and the other override files are used for development. The production environment makes use of linuxserver.io [letsencrypt container](https://github.com/linuxserver/docker-letsencrypt).

The included `provision.sh` script is meant to be run once to get your VPS in the right state. Deployment is handled by the Github workflow `deploy.yml` file.

This setup is intended to be used as a starting point, getting your project up and running on a single VPS in no time so that you can focus on development and start thinking about the way your CI/CD pipeline should be configured for that particular project.

I would love for this project to be extended to also serve as a base for larger scale applications that live in separate servers employing Kubernetes but my priorities lie elsewhere for the time being.

## Configuration

So, you cloned the repository. As this project heavily depends upon the [linuxserver.io](https://linuxserver.io) images, be sure to check out their documentation. You might also want to pop into their Discord server should you require help with their official images.

`copy .env.example .env` and configure for the repository that you want to serve. Make sure that the domain name resolves (https://dnschecker.org/) and your email address is formatted correctly so that LetsEncrypt can validate the domain and issue your certificates. Leave the `PUID/GUID` as is (for now) and specify the correct login credentials for your database.

Lastly, you want to get the repository onto your VPS. This is probably best done using secure file copy. Then, simply login to your server over SSH and execute `provision.sh` to configure and serve your project files.

Your project and container configuration is bind mounted into the container and lives in the `~/current/config` directory.

## Working

Simply `source docker-aliases.sh` to regain access to the command-line tools you are used to working with (`artisan`, `composer`, `npm`).
