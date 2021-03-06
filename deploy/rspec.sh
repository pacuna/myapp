#!/bin/bash
echo 'intalling gems'
RAILS_ENV=test bundle install
echo 'creating test database...'
RAILS_ENV=test rake db:create
echo 'migrating test database...'
RAILS_ENV=test rake db:migrate
echo 'running tests...'
RAILS_ENV=test rspec

return_code=$?
if [[ $return_code != 0 ]] ; then
  echo -e "Tests failed inside docker."
  exit $return_code
fi

