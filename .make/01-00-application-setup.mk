##@ [Application: Setup]

.PHONY: setup
setup: ## Setup the application & post installation
	"$(MAKE)" setup-$(ENVS)-init
	"$(MAKE)" composer ARGS="install"
	"$(MAKE)" setup-key

## Usage:
## setup-init
##
## setup-init ENVS="KEY_1=value1 KEY_2=value2"
.PHONY: setup-init
setup-init: ENVS= ## Initializes the .env file with ENV variables for laravel
setup-init:
	$(EXECUTE_IN_APPLICATION_CONTAINER) cp .env.example .env
	@for variable in $(ENVS); do \
	    $(EXECUTE_IN_APPLICATION_CONTAINER) echo $$variable | tee -a .env; \
	    done
	@echo "Please update your .env file with your settings"

.PHONY: setup-key
setup-key: ## Regenerating the Application Key
	$(EXECUTE_IN_APPLICATION_CONTAINER) php artisan key:generate;

.PHONY: setup-migrate
setup-migrate: ## Artisan migrate database with arguments ARGS="--seed"
	$(EXECUTE_IN_APPLICATION_CONTAINER) php artisan migrate $(ARGS);

.PHONY: setup-seed
setup-seed: ## Artisan Seeder with arguments ARGS="--class=Users"
	$(EXECUTE_IN_APPLICATION_CONTAINER) php artisan db:seed $(ARGS);

.PHONY: setup-db
setup-db: ## Setup the DB tables
	$(EXECUTE_IN_APPLICATION_CONTAINER) php artisan app:setup-db $(ARGS);

.PHONY: artisan
artisan: ## Run Artisan commands. Specify the command e.g. via ARGS="migrate --seed"
	$(EXECUTE_IN_APPLICATION_CONTAINER) php artisan $(ARGS);

.PHONY: composer
composer: ## Run Composer commands. Specify the command e.g. via ARGS="install"
	$(EXECUTE_IN_APPLICATION_CONTAINER) composer $(ARGS);
