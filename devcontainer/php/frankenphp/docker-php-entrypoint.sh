#!/bin/sh
set -e

# TODO: add deploy:setup command on first deployment

# TODO: add deploy:finalize command to handle post deployment (artisan down, a migrate, a optimize, etc.)

exec "$@"
