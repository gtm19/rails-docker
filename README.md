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
```

## Creating a new app

The following will create a boilerplate Rails app, with `simpleform`, `bootstrap`, and `devise` all locked and loaded by default.

```bash
./init.sh
```

### Rails Templates

You can (optionally) provide a different template as follows:

```bash
./init.sh --template minimal_docker
```

The only options at the moment are:

* `minimal_docker`
* `devise_docker` (default)

See [here](https://github.com/gtm19/rails-templates/) for the source.

### App name

You can optionally choose a name for your app by adding it as an unflagged argument.

By default, it will use the name of the working directory from where `./init.sh` is called.

```bash
./init.sh my-way-cool-app
```

## Rebuilding the image(s)

Changes to either the `Gemfile` or the `Dockerfile` will require a rebuild. This includes the changes which are caused by creating a new app.

```bash
docker-compose build
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
## Stopping the app

```bash
docker compose down
```
