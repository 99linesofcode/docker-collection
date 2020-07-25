node="node:14-alpine"
sourcedir="$PWD/config/nginx/www"
workdir="/app"

function artisan {
  docker exec -w /config/www -u 1000:1000 linesofcode.app php artisan "$@"
}

function composer {
  docker run --rm -t -v $sourcedir:$workdir composer "$@"
}

function npm {
  docker run --rm -t -w $workdir -v $sourcedir:$workdir $node sh -c "npm $@"
}
