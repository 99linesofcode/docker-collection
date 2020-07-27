# Docker Base
Interested in a bare metal Docker configuration to easily and more importantly safely serve your Laravel project with? Look no further.

Docker base is build ontop of the well supported [linuxserver.io](https://linuxserver.io) images and is only minimally extended and configured to be used in both development and production environments. `docker-compose.override.yml` and the other override files are used for development. The production environment makes use of linuxserver.io [letsencrypt container](https://github.com/linuxserver/docker-letsencrypt).

The included `provision.sh` script is meant to be run once to get your VPS in the right state. Deployment is handled by the Github workflow `deploy.yml` file.

This setup is intended to be used as a starting point, getting your project up and running on a single VPS in no time at so that you can focus on development and start thinking about the way your CI/CD pipeline should be configured for that particular project.

I would love for this project to be extended to also serve as a base for larger scale applications that live in separate servers employing Kubernetes but my priorities lie elsewhere for the time being.
