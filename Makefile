build:
	docker-compose build

prepare:
	docker-compose run --rm web rails db:drop db:create db:migrate db:seed

bash:
	docker-compose run --rm web /bin/bash

app:
	docker-compose up

rubocop:
	docker-compose run --rm web bundle exec rubocop -a

rswag:
	docker-compose run --rm web rails rswag

test:
	docker-compose run --rm web rails spec

console:
	docker-compose run --rm web rails c

.PHONY: app test