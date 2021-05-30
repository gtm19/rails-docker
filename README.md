# `rails-docker`

This repo contains the boilerplate code required to initialise a Rails app using Docker.

## Creating a new app

```
docker-compose run --no-deps web rails new . --force --database=postgresql
```