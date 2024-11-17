build:
	docker-compose build

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