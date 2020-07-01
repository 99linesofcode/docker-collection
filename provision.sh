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
  echo "Sourcing Docker dotenv file.."
  source .env

  if [ -n "$(find /config/nginx/www -maxdepth 0 -type d -empty 2>/dev/null)" ]; then
    if ! [[ -z $REPOSITORY ]]; then
      echo '$REPOSITORY not set. Please define the repository that should be pulled.'
      exit
    fi

    echo "Project not yet initialized. Pulling $REPOSITORY from github.com.."
    mkdir -p $PWD/config/nginx/www
    git clone git@github.com:99linesofcode/$REPOSITORY.git $PWD/config/nginx/www
    cp $PWD/config/nginx/www/.env.example $PWD/config/nginx/www/.env
  else
    echo "Project previously initialized. Continuing.."
  fi

  if [ -n `$(docker ps -q -f name=app)` ]; then
    echo "Starting Docker containers.."
    docker-compose -f docker-compose.yml -f docker-compose.prod.yml up -d
  else
    echo "Restarting Docker containers.."
    docker-compose down
    docker-compose -f docker-compose.yml -f docker-compose.prod.yml up -d
  fi

  if [ -n $(sed -n 's/^APP_KEY=//p' $PWD/config/nginx/www/.env) ]; then
    echo "Generating Laravel application key.."
    docker exec app php artisan key:generate
  fi
fi

echo "Done. All fired up and ready to serve!"
