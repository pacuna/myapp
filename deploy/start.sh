#!/bin/sh

if [ "$PASSENGER_APP_ENV" = "production" ]; then
    mkdir -p tmp/cache
    chown -R app:app tmp
    chmod 777 -R tmp/cache
    chown -R app:app public
    touch log/production.log
    chown -R app:app log
    RAILS_ENV=production bundle install &&
    RAILS_ENV=production bundle exec rake db:create &&
    RAILS_ENV=production bundle exec rake db:migrate &&
    RAILS_ENV=production bundle exec rake assets:precompile --trace
elif [ "$PASSENGER_APP_ENV" = "staging" ]; then
    mkdir -p tmp/cache
    chown -R app:app tmp
    chmod 777 -R tmp/cache
    chown -R app:app public
    touch log/production.log
    chown -R app:app log
    RAILS_ENV=production bundle install &&
    RAILS_ENV=production bundle exec rake db:create &&
    RAILS_ENV=production bundle exec rake db:migrate &&
    RAILS_ENV=production bundle exec rake assets:precompile --trace
elif [ "$PASSENGER_APP_ENV" = "development" ]; then
    RAILS_ENV=development bundle install --path /vendored_gems --verbose
else
    rm -rf public/assets
fi
