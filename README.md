# `rails-docker`

This repo contains the boilerplate code required to initialise a Rails app using Docker.

In order for this to be of any use, you will need to have the following installed on your machine:

* [Docker](https://docs.docker.com/get-docker/)
* [Docker Compose](https://docs.docker.com/compose/install/)

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
  --webpack
```

## Rebuilding the image(s)

Changes to either the `Gemfile` or the `Dockerfile` will require a rebuild. This includes the changes which are caused by creating a new app.

```bash
docker compose build
```

## Pointing the Rails app at the Postgres container

Change the `config/database.yml` so it includes this:

```yml
# config/database.yml
default: &default
  adapter: postgresql
  encoding: unicode
  host: db
  username: postgres
  password: password
  pool: 5
```

We also need to create the directory which will be mounted for the `db` service:

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
docker compose run web rails db:create
```

## Stopping the app

```bash
docker compose down
```
