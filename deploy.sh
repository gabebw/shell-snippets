#!/bin/sh

set -e

if [ $# -ne 1 ]; then
  echo "Usage: ./bin/deploy [ staging | production ]"
  exit 64
fi

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
