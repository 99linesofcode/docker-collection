node="node:14-alpine"
sourcedir="$PWD/config/nginx/www"
workdir="/app"

function artisan {
  docker exec -w /config/www linesofcode.app php artisan $1
}

function composer-install {
  docker run --rm -t -v $sourcedir:$workdir composer install
}

function npm-install {
  docker run --rm -t -w $workdir -v $sourcedir:$workdir $node sh -c "npm install"
}

function watch {
  docker run --rm -t -w $workdir -v $sourcedir:$workdir $node sh -c "npm run watch"
}

function dev {
  docker run --rm -t -w $workdir -v $sourcedir:$workdir $node sh -c "npm run dev"
}

function prod {
  docker run --rm -t -w $workdir -v $sourcedir:$workdir $node sh -c "npm run dev"
}
