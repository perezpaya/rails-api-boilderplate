#!/bin/bash
if [ "$RAILS_ENV" == "test" ]; then
  bundle exec rails spec
else
  rm -rf tmp/
  rails db:migrate
  bundle exec rails server -p $PORT -b '0.0.0.0'
fi

