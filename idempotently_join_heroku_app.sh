#!/usr/bin/env sh

idempotently_join_heroku_app() {
  # `heroku join` exits 1 if the user has already joined the app _and_ if the user
  # can't join the app. So, call `heroku join` but grep for a specific phrase to
  # see if a user successfully joined the app. Team admins are already a part of
  # every team app and can't join apps.
  if heroku join --app "$1" 2>&1 | grep -Eq 'already a collaborator|... done|team admin and cannot be joined'; then
    printf 'You are a collaborator on the "%s" Heroku app\n' "$1"
  else
    printf 'Ask for access to the "%s" Heroku app\n' "$1"
    exit 1
  fi
}
