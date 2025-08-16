# Just a demo app

The reason for this is just to test some stuff by using a simple Ruby CLI application

## Requirements

- [Docker](https://www.docker.com) installed and running

## Usefull things

- `$ make help` => Lists alle available make commands
- `$ make run`  => Runs the app as a "one-off"
- Don't use `gem install {gem}` inside a container, but rather add gems to the Gemfile or use `bundle add {gem}`

## Setup

- `$ make setup`: Initiates everything (building images, installing gems)

## Daily dev

- `$ make dev`: Fires a shell inside your container to use for normale development

## Container dependencies

If you need some dependencies that aren't already installed in the container then you can add the needed dependendency in `.build-deps` and then run `make build` or `make setup` to rebuild the image with the new dependency.
