help: ## Show this help message
		@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'

setup: env build bundle ## Initiates everything (building images, installing gems)

bundle: ## Install missing gems
	docker-compose run --rm app bundle install

run: ## Runs the app in a one off
	docker-compose run --rm app ./bin/cli.rb hello Alice

up: ## Runs the development server
	docker-compose up

dev: ## Fires a shell inside your container to use for normale development
	docker-compose run --rm app bash

build: ## Builds the image
	docker-compose build

down: ## Removes all the containers and tears down the setup
	docker-compose down

env: ## Creates .env.dev from .env.example (unless it already exists)
	cp -u .env.example .env.dev
