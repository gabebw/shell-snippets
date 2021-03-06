#!/bin/sh

set -e

if [ $# -ne 1 ]; then
  echo "Usage: ./bin/deploy [ staging | production ]"
  exit 64
fi

pending_migrations(){
  git diff --quiet "$1"..master -- db/migrate
}
environment=$1
git fetch "$environment"

# Could also do `git rev-parse HEAD` to deploy the current branch, whatever it
# is
master_sha=$(git rev-parse origin/master)
environment_sha=$(git rev-parse "${environment}/master")

if [ "$master_sha" = "$environment_sha" ]; then
  echo "Already up-to-date, doing nothing"
  exit 0
fi

git push "$environment" master

if pending_migrations "$environment_sha"; then
  heroku run rake db:migrate --remote "$environment"
fi
