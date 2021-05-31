# `rails-docker`

This repo contains the boilerplate code required to initialise a Rails app using Docker.

## Creating a new app

```bash
docker compose run --no-deps web rails new . --force --database=postgresql
```

## Rebuilding the image(s)

Changes to either the `Gemfile` or the `Dockerfile` will require a rebuild:

```bash
docker compose rebuild
```