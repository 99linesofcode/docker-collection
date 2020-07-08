#!/bin/bash

if ! [ -x $(command -v docker) ]; then
  echo "provision.sh | Installing prerequisite packages.."
  sudo apt update && apt install --no-install-recommends -y \
       apt-transport-https \
       ca-certificates \
       curl \
       software-properties-common \
       git
  mkdir -p ~/current
  echo "provision.sh | Installing Docker and Docker Compose.."
  curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
  sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu focal stable"
  sudo apt update
  apt-cache policy docker-ce
  sudo apt install --no-install-recommends -y docker-ce docker-compose
fi

echo "provision.sh | All prerequisites installed. Continuing.."
cd ~/current

if ! [ -f .env.example ]; then
  echo "provision.sh | $PWD/.env.example is missing. Cannot continue.."
  exit
fi

if ! [ -f .env ]; then
  echo "provision.sh | Copying .env from $PWD/.env.example.."
  cp .env.example .env
fi

source .env

if [ -z $REPOSITORY ]; then
  echo '$REPOSITORY not defined. What repository do you want to pull?'
  read -p 'git@github.com:99linesofcode/' repo
  sed -i "s/REPOSITORY=.*/REPOSITORY=$repo/g" .env
  source .env
fi

if ! [[ -d $PWD/config/nginx/www && -n "$(ls -A $PWD/config/nginx/www)" ]]; then
  echo "provision.sh | Pulling $REPOSITORY from github.com.."
  mkdir -p $PWD/config/nginx/www
  git clone git@github.com:99linesofcode/$REPOSITORY.git $PWD/config/nginx/www
fi

if [ -z $(docker ps -q -f name=linesofcode.app) ]; then
  echo "provision.sh | Starting Docker containers.."
  docker-compose -f docker-compose.yml up -d
else
  echo "provision.sh | Restarting Docker containers.."
  docker-compose down
  docker-compose -f docker-compose.yml up -d
fi

if grep -q "laravel/framework" $PWD/config/nginx/www/composer.json; then
  echo "provision.sh | $REPOSITORY looks to be a Laravel project. Configuring.."

  if [ ! -f $PWD/config/nginx/www/.env ]; then
    if [ ! -f $PWD/config/nginx/www/.env.example ]; then
      echo "provision.sh | Cannot copy .env.example to .env. Make sure either exists."
      exit
    fi

    cp $PWD/config/nginx/www/.env.example $PWD/config/nginx/www/.env
  fi

  echo "provision.sh | Installing Composer dependencies.."
  docker run --rm -t -v $PWD/config/nginx/www:/app composer install

  if [ -z $(sed -n 's/^APP_KEY=//p' $PWD/config/nginx/www/.env) ]; then
    echo "provision.sh | Application key not set. Generating a new one.."
    docker exec -w /config/www linesofcode.app php artisan key:generate
  fi

  echo "provision.sh | Installing Vue dependencies.."
  docker run --rm -t -w /app -v $PWD/config/nginx/www:/app node:14-alpine sh -c "npm install && npm run prod"
fi

echo "provision.sh | Done. All fired up and ready to serve!"
