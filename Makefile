BLACK ?= \033[0;30m
RED ?= \033[0;31m
GREEN ?= \033[0;32m
YELLOW ?= \033[0;33m
BLUE ?= \033[0;34m
PURPLE ?= \033[0;35m
CYAN ?= \033[0;36m
GRAY ?= \033[0;37m
WHITE ?= \033[1;37m
COFF ?= \033[0m

.PHONY: all help build build-backend build-frontend start-all-services start-backend start-frontend stop-all-services start-backend start-frontend stop-all-services stop-backend stop-frontend makemigrations migrate load-initial-data create-superuser collectstatic show-all-logs show-all-logs-interactive show-backend-logs show-backend-logs-interactive show-frontend-logs show-frontend-logs-interactive eslint eslint-fix lint-backend lint-frontend lint-backend-fix quality format

help:
	@echo -e "\n$(WHITE)Available commands:$(COFF)"
	@echo -e "$(CYAN)make build$(COFF)                          		- Builds or rebuilds services"
	@echo -e "$(CYAN)make build-dev$(COFF)                      		- Builds or rebuilds services in development"
	@echo -e "$(CYAN)make build-backend$(COFF)                  		- Builds or rebuilds backend"
	@echo -e "$(CYAN)make build-backend-dev$(COFF)              		- Builds or rebuilds backend services in development"
	@echo -e "$(CYAN)make build-frontend$(COFF)                 		- Builds or rebuilds frontend"
	@echo -e "$(CYAN)make build-frontend-dev$(COFF)             		- Builds or rebuilds frontend services in development"
	@echo -e "$(RED)make start-all-services$(COFF)             		    - Starts all services"
	@echo -e "$(RED)make start-all-services-dev$(COFF)         		    - Starts all services in development"
	@echo -e "$(RED)make start-backend$(COFF)             				- Starts backend service"
	@echo -e "$(RED)make start-backend-dev$(COFF)             			- Starts backend service in development"
	@echo -e "$(RED)make start-frontend$(COFF)             			    - Starts frontend service"
	@echo -e "$(RED)make start-frontend-dev$(COFF)             		    - Starts frontend service in development"
	@echo -e "$(GRAY)make stop-all-services$(COFF)             			- Stops all services"
	@echo -e "$(GRAY)make stop-all-services-dev$(COFF)             		- Stops all services"
	@echo -e "$(GRAY)make stop-backend$(COFF)             				- Stops backend service"
	@echo -e "$(GRAY)make stop-backend-dev$(COFF)             			- Stops backend service in development"
	@echo -e "$(GRAY)make stop-frontend$(COFF)             				- Stops frontend service"
	@echo -e "$(GRAY)make stop-frontend-dev$(COFF)             			- Stops frontend service in development"
	@echo -e "$(GRAY)make delete-all-volumes$(COFF)             		- Deletes all volumes"
	@echo -e "$(PURPLE)make makemigrations$(COFF)               		- Runs django's makemigrations command"
	@echo -e "$(PURPLE)make makemigrations-dev$(COFF)           		- Runs django's makemigrations command in development"
	@echo -e "$(PURPLE)make migrate$(COFF)                      		- Runs django's migrate command"
	@echo -e "$(PURPLE)make migrate-dev$(COFF)                  		- Runs django's migrate command in development"
	@echo -e "$(PURPLE)make load-initial-data$(COFF)                  	- Loads django's fixtures"
	@echo -e "$(PURPLE)make load-initial-data-dev$(COFF)                - Loads django's fixtures in development"
	@echo -e "$(PURPLE)make load-gis-data$(COFF)                        - Loads GIS data into the database"
	@echo -e "$(PURPLE)make load-gis-data-dev$(COFF)                    - Loads GIS data into the database in development"
	@echo -e "$(PURPLE))make create-superuser$(COFF)                   	- Runs django's createsuperuser command"
	@echo -e "$(PURPLE))make create-superuser-dev$(COFF)               	- Runs django's createsuperuser command in development"
	@echo -e "$(PURPLE)make collectstatic$(COFF)                		- Runs the Django's collectstatic command"
	@echo -e "$(PURPLE)make collectstatic-dev$(COFF)            		- Runs the Django's collectstatic command in development"
	@echo -e "$(YELLOW)make show-all-logs$(COFF)                        - Shows all server logs"
	@echo -e "$(YELLOW)make show-all-logs-dev$(COFF)                    - Shows all server logs in development"
	@echo -e "$(YELLOW)make show-all-logs-interactive$(COFF)            - Shows all interactive logs"
	@echo -e "$(YELLOW)make show-all-logs-interactive-dev$(COFF)        - Shows all interactive logs in development"
	@echo -e "$(YELLOW)make show-backend-logs$(COFF)                 	- Shows backend server logs"
	@echo -e "$(YELLOW)make show-backend-logs-dev$(COFF) 				- Shows backend logs in development"
	@echo -e "$(YELLOW)make show-backend-logs-interactive$(COFF) 		- Shows backend interactive logs"
	@echo -e "$(YELLOW)make show-backend-logs-interactive-dev$(COFF) 	- Shows backend interactive logs in development"
	@echo -e "$(YELLOW)make show-frontend-logs$(COFF) 					- Shows frontend logs"
	@echo -e "$(YELLOW)make show-frontend-logs-dev$(COFF) 				- Shows frontend logs in development"
	@echo -e "$(YELLOW)make show-frontend-logs-interactive$(COFF) 		- Shows frontend logs interactively"
	@echo -e "$(YELLOW)make show-frontend-logs-interactive-dev$(COFF)  	- Shows frontend logs interactively in development"
	@echo -e "$(BLUE)make eslint$(COFF) 								- Runs ESLint in frontend"
	@echo -e "$(BLUE)make eslint-fix$(COFF) 							- Fix code using ESLint in frontend"
	@echo -e "$(BLUE)make lint-backend$(COFF) 						    - Runs Black check on backend"
	@echo -e "$(BLUE)make lint-backend-fix$(COFF) 					    - Runs Black formatting in backend"
	@echo -e "$(BLUE)make quality$(COFF) 								- Runs code quality tests on your code"
	@echo -e "$(BLUE)make format$(COFF) 								- Runs code formatters on your code"

build:
	@echo -e "$(CYAN)Building services:$(COFF)"
	@docker-compose -f docker-compose.yml build

build-dev:
	@echo -e "$(CYAN)Building services for development:$(COFF)"
	@docker-compose -f docker-compose-dev.yml build

build-backend:
	@echo -e "$(CYAN)Building backend services:$(COFF)"
	@docker-compose -f docker-compose.yml build backend

build-backend-dev:
	@echo -e "$(CYAN)Building backend services for development:$(COFF)"
	@docker-compose -f docker-compose-dev.yml build backend

build-frontend:
	@echo -e "$(CYAN)Building frontend services:$(COFF)"
	@docker-compose -f docker-compose.yml build frontend

build-frontend-dev:
	@echo -e "$(CYAN)Building frontend services for development:$(COFF)"
	@docker-compose -f docker-compose-dev.yml build frontend

start-all-services:
	@echo -e "$(RED)Starting all services:$(COFF)"
	@docker-compose -f docker-compose.yml up -d

start-all-services-dev:
	@echo -e "$(RED)Starting all services in development:$(COFF)"
	@docker-compose -f docker-compose-dev.yml up -d

start-backend:
	@echo -e "$(RED)Starting backend services:$(COFF)"
	@docker-compose -f docker-compose.yml up -d backend

start-backend-dev:
	@echo -e "$(RED)Building backend services for development:$(COFF)"
	@docker-compose -f docker-compose-dev.yml up -d backend

start-frontend:
	@echo -e "$(RED)Starting backend services:$(COFF)"
	@docker-compose -f docker-compose.yml up -d frontend

start-frontend-dev:
	@echo -e "$(RED)Building backend services for development:$(COFF)"
	@docker-compose -f docker-compose-dev.yml up -d frontend

stop-all-services:
	@echo -e "$(GRAY)Stopping all services:$(COFF)"
	@docker-compose -f docker-compose.yml down

stop-all-services-dev:
	@echo -e "$(GRAY)Stopping all services:$(COFF)"
	@docker-compose -f docker-compose-dev.yml down

stop-backend:
	@echo -e "$(GRAY)Stopping backend services:$(COFF)"
	@docker-compose -f docker-compose.yml down backend

stop-backend-dev:
	@echo -e "$(GRAY)Stopping backend services in development:$(COFF)"
	@docker-compose -f docker-compose-dev.yml down backend

stop-frontend:
	@echo -e "$(GRAY)Stopping frontend services:$(COFF)"
	@docker-compose -f docker-compose.yml down frontend

stop-frontend-dev:
	@echo -e "$(GRAY)Stopping frontend services for development:$(COFF)"
	@docker-compose -f docker-compose-dev.yml down frontend

delete-all-volumes:
	@echo -e "$(GREEN)Deleting all volumes:$(COFF)"
	@docker-compose -f docker-compose.yml down -v

delete-all-volumes-dev:
	@echo -e "$(GREEN)Deleting all volumes in development:$(COFF)"
	@docker-compose -f docker-compose-dev.yml down -v

makemigrations:
	@echo -e "$(PURPLE)Making migrations:$(COFF)"
	@docker-compose -f docker-compose.yml run --rm backend python ./manage.py makemigrations $(cmd)

makemigrations-dev:
	@echo -e "$(PURPLE)Making migrations for development:$(COFF)"
	@docker-compose -f docker-compose-dev.yml run --rm backend python ./manage.py makemigrations $(cmd)

migrate:
	@echo -e "$(PURPLE)Building frontend services:$(COFF)"
	@docker-compose -f docker-compose.yml run --rm backend python ./manage.py migrate $(cmd)

migrate-dev:
	@echo -e "$(PURPLE)Updating the database for development:$(COFF)"
	@docker-compose -f docker-compose-dev.yml run --rm backend python ./manage.py migrate $(cmd)

load-initial-data:
	@echo -e "$(PURPLE)Loading django fixture:$(COFF)"
	@docker-compose -f docker-compose-dev.yml run --rm backend python ./manage.py loaddata users/fixtures/users.json

load-initial-data-dev:
	@echo -e "$(PURPLE)Loading django fixture:$(COFF)"
	@docker-compose -f docker-compose-dev.yml run --rm backend python ./manage.py loaddata users/fixtures/users.json

load-gis-data:
	@echo -e "$(PURPLE)Loading spatial data:$(COFF)"
	@docker-compose -f docker-compose.yml run --rm backend python ./manage.py shell -c "from data import load_data; load_data.run()"

load-gis-data-dev:
	@echo -e "$(PURPLE)Loading spatial data in development:$(COFF)"
	@docker-compose -f docker-compose-dev.yml run --rm backend python ./manage.py shell -c "from data import load_data; load_data.run()"

create-superuser:
	@echo -e "$(PURPLE)Creating Docker images:$(COFF)"
	@docker-compose -f docker-compose.yml run --rm backend python ./manage.py createsuperuser

create-superuser-dev:
	@echo -e "$(PURPLE)Creating Docker images:$(COFF)"
	@docker-compose -f docker-compose-dev.yml run --rm backend python ./manage.py createsuperuser

collectstatic:
	@echo -e "$(PURPLE)Copying static files and assets:$(COFF):$(COFF)"
	@docker-compose -f docker-compose.yml --rm backend python ./manage.py collectstatic --no-input $(cmd)

collectstatic-dev:
	@echo -e "$(PURPLE)Copying static files and assets in development:$(COFF)"
	@docker-compose -f docker-compose-dev.yml --rm backend python ./manage.py collectstatic $(cmd)

show-all-logs:
	@echo -e "$(YELLOW)Printing all logs:$(COFF):$(COFF)"
	@docker-compose -f docker-compose.yml logs $(cmd)

show-all-logs-dev:
	@echo -e "$(YELLOW)Printing all logs in development:$(COFF)"
	@docker-compose -f docker-compose-dev.yml logs $(cmd)

show-all-logs-interactive:
	@echo -e "$(YELLOW)Printing all logs interactively:$(COFF):$(COFF)"
	@docker-compose -f docker-compose.yml logs -f $(cmd)

show-all-logs-interactive-dev:
	@echo -e "$(YELLOW)Printing all logs interactively in development:$(COFF)"
	@docker-compose -f docker-compose-dev.yml logs -f $(cmd)

show-backend-logs:
	@echo -e "$(YELLOW)Print backend logs:$(COFF):$(COFF)"
	@docker-compose -f docker-compose.yml logs backend $(cmd)

show-backend-logs-dev:
	@echo -e "$(YELLOW)Print backend logs in development:$(COFF)"
	@docker-compose -f docker-compose-dev.yml logs backend $(cmd)

show-backend-logs-interactive:
	@echo -e "$(YELLOW)Printing backend logs interactively:$(COFF)"
	@docker-compose -f docker-compose-dev.yml logs -f backend $(cmd)

show-backend-logs-interactive-dev:
	@echo -e "$(YELLOW)Printing all logs interactively in development:$(COFF)"
	@docker-compose -f docker-compose-dev.yml logs -f backend $(cmd)

show-frontend-logs:
	@echo -e "$(YELLOW)Print frontend logs:$(COFF):$(COFF)"
	@docker-compose -f docker-compose.yml logs frontend $(cmd)

show-frontend-logs-dev:
	@echo -e "$(YELLOW)Print frontend logs in development:$(COFF)"
	@docker-compose -f docker-compose-dev.yml logs frontend $(cmd)

show-frontend-logs-interactive:
	@echo -e "$(YELLOW)Print frontend logs interactively:$(COFF)"
	@docker-compose -f docker-compose-dev.yml logs -f frontend $(cmd)

show-frontend-logs-interactive-dev:
	@echo -e "$(YELLOW)Print frontend logs interactively in development:$(COFF)"
	@docker-compose -f docker-compose-dev.yml logs -f frontend $(cmd)

eslint:
	@echo -e "$(BLUE)Running ESLint:$(COFF)"
	@docker-compose -f docker-compose-dev.yml run --rm frontend pnpm run lint

eslint-fix:
	@echo -e "$(BLUE)Running ESLint fix:$(COFF)"
	@docker-compose -f docker-compose-dev.yml run --rm frontend pnpm run lint-fix

lint-backend:
	@echo -e "$(BLUE)Running Black check on backend:$(COFF)"
	@docker-compose -f docker-compose-dev.yml run --rm backend black --check backend/

lint-backend-fix:
	@echo -e "$(BLUE)Running Black formatting:$(COFF)"
	@docker-compose -f docker-compose-dev.yml run --rm backend black backend/

quality: eslint lint-backend
	@echo -e "$(BLUE)No code style issues detected.$(COFF)"

format: eslint-fix lint-backend-fix
