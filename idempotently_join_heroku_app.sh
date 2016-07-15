# `heroku join` exits 1 if the user has already joined the app _and_ if the user
# can't join the app. So, call `heroku join` but grep for a specific phrase to
# see if a user successfully joined the app.
if heroku join --app "$1" 2>&1 | grep -Eq 'already a collaborator|... done'; then
  printf 'You are a collaborator on the "%s" Heroku app\n' "$1"
else
  printf 'Ask for access to the "%s" Heroku app\n' "$1"
  exit 1
fi
