# Online Enrollment System

### ***Distributed Fault Tolerance***

## Pre-requisites



Docker Setup
command: bash -c "rm -f tmp/pids/server.pid && bundle exec rails db:create db:migrate db:seed && bundle exec rails server -b 0.0.0.0"


docker compose down -v --remove-orphans
docker compose up --build