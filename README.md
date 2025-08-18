# Just for fun

This is just a fun little CLI app where I test some AI stuff. At the moment it just gives some information about Rocket League (esport) related stuff. 

Docker and Makefiles are heaveliy inspired by [Docker Ruby Boiler Plate](https://github.com/amrabdelwahab/docker-ruby-boilerplate/tree/master) written by [@amrabdelwahab](https://github.com/amrabdelwahab)

## Requirements

- [Docker](https://www.docker.com) installed and running

## Usefull things

- `$ make help` => Lists alle available make commands
- `$ make run`  => Runs the app as a "one-off"
- `$ make test`  => Runs the test as a "one-off"
- `$ make rubo`  => Runs the rubocop as a "one-off"
- Don't use `gem install {gem}` inside a container, but rather add gems to the Gemfile or use `bundle add {gem}`

## Setup

- `$ make setup`: Initiates everything (building images, installing gems)
  - Will ask you for an open ai API key
  - **NOTE:** You don't actually have to use setup. If you e.g. use `make run` or `make dev` then the needed parts of setup will be run automatically. E.g. if someone has changed the gemfile and you pull the latest changes, then bundle will automatically be called when running `make dev`.

## Daily dev

- `$ make dev`: Fires a shell inside your container to use for normale development

## Container dependencies

If you need some dependencies that aren't already installed in the container then you can add the needed dependendency in `.build-deps` and then run `make build` or `make setup` to rebuild the image with the new dependency.
