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

env: ## Ensure .env.dev exists and has OPENAI_API_KEY set
	@if [ ! -f .env.dev ]; then \
		cp -u .env.example .env.dev; \
	fi; \
	if ! grep -q '^OPENAI_API_KEY=' .env.dev || grep -q '^OPENAI_API_KEY=$$' .env.dev; then \
		read -p "Enter your OPENAI_API_KEY: " API_KEY; \
		sed -i.bak '/^OPENAI_API_KEY=/d' .env.dev; rm -f .env.dev.bak; \
		echo "OPENAI_API_KEY=$$API_KEY" >> .env.dev; \
		echo "✅ Saved OPENAI_API_KEY to .env.dev"; \
	else \
		echo "✅ OPENAI_API_KEY already set in .env.dev"; \
	fi

# --- Utility targets ---

list: ## Lists thor commands
	docker compose run --rm app thor list

down: ## Removes all the containers and tears down the setup
	docker compose down

down-v: ## Removes all the containers (AND volumes) and tears down the setup
	docker compose down -v
