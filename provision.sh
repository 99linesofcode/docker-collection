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
  echo "Installing Composer dependency manager.."
  RUN curl --silent --show-error https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer && \
      composer global require hirak/prestissimo --no-suggest --no-interaction;
fi

echo "All prerequisites installed. Continuing.."
cd ~/current

if ! [ -f .env ]; then
  echo "Missing Docker dotenv file. Please copy and configure env-example before continuing."
  exit
else
  source .env && echo "Sourced .env"

  if [[ -z `ls -A $PWD/config/nginx/www` ]]; then
    if ! [[ -z $REPOSITORY ]]; then
      echo '$REPOSITORY not set. Please define the repository that should be pulled.'
      exit
    fi

    echo "Project not yet initialized. Pulling $REPOSITORY from github.com.."
    mkdir -p $PWD/config/nginx/www
    git clone git@github.com:99linesofcode/$REPOSITORY.git $PWD/config/nginx/www
  else
    echo "Project previously initialized. Continuing.."
  fi

  if [ ! `docker ps -q -f name=app` ]; then
    echo "Starting Docker containers.."
    docker-compose up -f docker-compose.yml -f docker-compose.prod.yml -d
  fi

  if ! [ -f $PWD/config/nginx/www/.env ]; then
    echo "Copy .env file."
    cp $PWD/config/nginx/www/.env.example $PWD/config/nginx/www/.env
    echo "Generate application encryption key."
    docker exec app php artisan key:generate
  fi
fi

echo "All fired up and ready to serve!"
