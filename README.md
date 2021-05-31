# `rails-docker`

This repo contains the boilerplate code required to initialise a Rails app using Docker.

## Clone this repo

First clone the repo (replacing `YOUR_APP_NAME` with the name of your app), and remove the `git` history.

```bash
git clone git@github.com:gtm19/rails-docker.git YOUR_APP_NAME
cd YOUR_APP_NAME
rm -rf .git
```

## Creating a new app

The following will create a boilerplate Rails app, with `simpleform`, `bootstrap`, and `devise` all locked and loaded.

```bash
docker compose run --no-deps web rails new . \
  --force \
   --database=postgresql \
   --webpack \
   -m https://raw.githubusercontent.com/gtm19/rails-templates/master/devise.rb
```

## Rebuilding the image(s)

Changes to either the `Gemfile` or the `Dockerfile` will require a rebuild. This includes the changes which are caused by creating a new app.

```bash
docker compose rebuild
```

## Initialising the database volume folder

The [docker-compose.yml](docker-compose.yml) file mounts a volume for the database from the `tmp/db` directory of the app on the host machine. You _may_ need to create this folder before proceeding.

```bash
mkdir tmp/db
```

## Running the app

```bash
docker compose up
```

## Rebuilding the app

If you make changes to the Gemfile or the Compose file to try out some different configurations, you need to rebuild.

Some changes require only 
```
docker compose up --build
```
...but a full rebuild requires: 
```
docker compose run web bundle install
docker compose up --build
```

## Initialise the database

```bash
docker run web rails db:create
```

## Stopping the app

```bash
docker compose down
```
