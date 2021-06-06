prod-env = -p react_prod -f docker-compose-prod.yml
local-env = -p react_local

up:
	docker-compose $(local-env) up -d react
up-b:
	docker-compose $(local-env) up --no-deps -d --build
down:
	docker-compose $(local-env) down --remove-orphans
down-v:
	docker-compose $(local-env) down --remove-orphans -v
start:
	docker-compose $(local-env) start
stop:
	docker-compose $(local-env) stop
sh:
	docker-compose $(local-env) exec react sh
yarn-test:
	docker-compose $(local-env) exec react yarn test
add-pkg:
	docker-compose $(local-env) exec react npm install $(pkg)
reload: down up
rebuild: down up-b

p-up:
	docker-compose $(prod-env) up -d react
p-up-b:
	docker-compose $(prod-env) up --no-deps -d --build
p-down:
	docker-compose $(prod-env) down --remove-orphans
p-down-v:
	docker-compose $(prod-env) down --remove-orphans -v
p-start:
	docker-compose $(prod-env) start
p-stop:
	docker-compose $(prod-env) stop
p-sh:
	docker-compose $(prod-env) exec react sh
p-reload: p-down p-up
p-rebuild: p-down p-up-b
