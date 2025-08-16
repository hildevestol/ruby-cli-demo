help: ## Show this help message
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'

run: setup ## Runs the app in a one off. If needed it also runs setup
	docker compose run --rm app thor app:ai

dev: setup ## Fires a shell inside your container to use for normale development
	docker compose run --rm app bash

up: setup ## Runs the development server
	docker compose up

# --- Run prerequisites ---

setup: env build bundle ## Initiates everything (building images, installing gems)

# Bundle depends on Gemfile + Gemfile.lock
Gemfile.lock: Gemfile
	docker compose run --rm app bundle install

bundle: Gemfile.lock ## Install missing gems
	@true

build: .build_stamp ## Builds the image

.build_stamp: Dockerfile
	docker compose build
	touch .build_stamp

# Env depends on .env.dev
.env.dev: .env.example
	cp -u .env.example .env.dev

env: .env.dev ## Creates .env.dev from .env.example (unless it already exists)
	@true

# --- Utility targets ---

list: ## Lists thor commands
	docker compose run --rm app thor list

down: ## Removes all the containers and tears down the setup
	docker compose down

down-v: ## Removes all the containers (AND volumes) and tears down the setup
	docker compose down -v
