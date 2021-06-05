#!/bin/bash
set -e

NAME=$(basename $(pwd))
TEMPLATE="devise_docker"
DOCKER_COMPOSE_VERSION="3.9"

if [[ "$NAME" != "rails-docker" ]]; then
    echo "Removing git history"
    rm -rf .git
fi

# Loop through arguments and process them
for arg in "$@"
do
    case $arg in
        -t|--template)
        TEMPLATE="$2"
        shift # Remove argument name from processing
        shift # Remove argument from processing
        ;;
        *)
        if [[ "$1" != "" ]]; then
            NAME="$1"
            shift
        fi
        ;;
    esac
done

TEMPLATE_FILE="https://raw.githubusercontent.com/gtm19/rails-templates/master/$TEMPLATE.rb"

echo "Creating app with name: $NAME"
echo "Using template: $TEMPLATE_FILE"

cat > docker-compose.yml <<EOL
version: "$DOCKER_COMPOSE_VERSION"
services:
  db:
    image: postgres
    ports:
      - 5432:5432
    volumes:
      - ./tmp/db:/var/lib/postgresql/data
    environment:
      POSTGRES_PASSWORD: password
  web:
    build:
      context: .
      args:
        - app_name=$NAME
    command: bash -c "rm -f tmp/pids/server.pid && bundle exec rails s -p 3000 -b '0.0.0.0'"
    volumes:
      - .:/$NAME
    ports:
      - 3000:3000
    depends_on:
      - db
EOL

mkdir -p tmp/db

docker compose build --build-arg app_name=$NAME

docker compose run web rails new . \
  --force \
  --database=postgresql \
  --webpack \
  -m $TEMPLATE_FILE

docker compose build --build-arg app_name=$NAME
