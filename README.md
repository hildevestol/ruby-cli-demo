# Just for fun

This is just a fun little CLI app where I test some AI stuff. At the moment it just gives some information about Rocket League (esport) related stuff. 

Docker and Makefiles are heaveliy inspired by [Docker Ruby Boiler Plate](https://github.com/amrabdelwahab/docker-ruby-boilerplate/tree/master) written by [@amrabdelwahab](https://github.com/amrabdelwahab)

## What does it do?

The application uses [thor](https://github.com/rails/thor) for simplifying the cli and at the moment have the following options. (To list the current options you can do `make list` or `thor list` if you are already inside the container)

- `thor app:ai`: Just puts out a dummy text from the AI
- `thor app:ewc`: First manually fetches information from Liquipedia for EWC Rocket League 2025 and then passes that information to the AI to get a summary of the tournaments, result of the latest matches, upcoming matches, etc (NOTE: The tournament is now over, but was just used as a test case while it was still running)
- `thor app:rlcs`: Asks the AI (`gpt-4o-mini-search-preview`) directly to go to a specific Liquipedia page and give me a list of all the teams that has won RLCS Worlds including the players on the team.
- `thor app:tournaments`: Asks the AI (`gpt-4o-mini-search-preview`) directly to go to a specific Liquipedia page and give me a list of all upcomming Rocket League tournaments.

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
