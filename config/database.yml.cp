# SQLite version 3.x
#   gem install sqlite3
#
#   Ensure the SQLite 3 gem is defined in your Gemfile
#   gem 'sqlite3'
#
default: &default
  adapter: postgresql
  pool: <%= ENV.fetch("RAILS_MAX_THREADS") { 5 } %>
  timeout: 5000

development:
  <<: *default
  host: localhost
  database: fuitter_development
  pool: 5
  username: postgres # <== Change me!!
  password: postgres # <== Change me too!

# Warning: The database defined as "test" will be erased and
# re-generated from your development database when you run "rake".
# Do not set this db to the same as development or production.
test:
  <<: *default
  host: localhost
  database: fuitter_test
  pool: 5
  username: postgres # <== Change me!!
  password: postgres # <== Change me too!

production:
  <<: *default
  database: db/production.sqlite3
