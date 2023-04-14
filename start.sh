#!/bin/sh

if ["${RAILS_ENV}" = "production"]
    bundle exec rails assets:precompile
    bundle exec unicorn -p 3000 -c /app/config/unicorn.rb
then
    bundle exec rails s -p 3000 -b '0.0.0.0'"
fi