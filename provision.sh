#!/bin/bash

if ! [ -x $(command -v docker) ]; then
  echo "Installing prerequisite packages.."
  sudo apt update && apt install --no-install-recommends -y \
       apt-transport-https \
       ca-certificates \
       curl \
       software-properties-common \
       git
  mkdir -p ~/current
  echo "Installing Docker and Docker Compose.."
  curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
  sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu focal stable"
  sudo apt update
  apt-cache policy docker-ce
  sudo apt install --no-install-recommends -y docker-ce docker-compose
fi

echo "All prerequisites installed. Continuing.."
cd ~/current

if ! [ -f .env.example ]; then
  echo "$PWD/.env.example is missing. Cannot continue.."
  exit
fi

if ! [ -f .env ]; then
  echo "Copying .env from $PWD/.env.example.."
  cp .env.example .env
fi

source .env

if [ -z $REPOSITORY ]; then
  echo '$REPOSITORY not defined. What repository do you want to pull?'
  read -p 'git@github.com:99linesofcode/' repo
  sed -i "s/REPOSITORY=.*/REPOSITORY=$repo/g" .env
fi

if [ -n $(find $PWD/config/nginx/www -maxdepth 0 -type d -empty 2>/dev/null) ]; then
  echo "Pulling $REPOSITORY from github.com.."
  mkdir -p $PWD/config/nginx/www
  git clone git@github.com:99linesofcode/$REPOSITORY.git $PWD/config/nginx/www
fi

if [ -z $(docker ps -q -f name=app) ]; then
  echo "Starting Docker containers.."
  docker-compose -f docker-compose.yml up -d
else
  echo "Restarting Docker containers.."
  docker-compose down
  docker-compose -f docker-compose.yml up -d
fi

if grep -q "laravel/framework" $PWD/config/nginx/www/composer.json; then
  echo "$REPOSITORY looks to be a Laravel project. Configuring.."

  if [ ! -f $PWD/config/nginx/www/.env ] && [ -f $PWD/config/nginx/www/.env.example ]; then
    cp $PWD/config/nginx/www/.env.example $PWD/config/nginx/www/.env
  else
    echo "$PWD/config/nginx/www/.env.example is missing. Make sure it exists before continuing."
    exit
  fi

  echo "Installing Composer dependencies.."
  docker run --rm -t -v $PWD/config/nginx/www:/app composer install

  if [ -z $(sed -n 's/^APP_KEY=//p' $PWD/config/nginx/www/.env) ]; then
    echo "Application key not set. Generating a new one.."
    docker exec app php artisan key:generate
  fi

  echo "Installing Vue dependencies.."
  docker run --rm -t -w /app -v $PWD/config/nginx/www:/app node:14-alpine sh -c "npm install --production && npm run prod"
fi

echo "Done. All fired up and ready to serve!"
