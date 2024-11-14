build:
	docker-compose build

bash:
	docker-compose run --rm web /bin/bash

up:
	docker-compose up

swaggerize:
	docker-compose run --rm web rails rswag:specs:swaggerize

rswag:
	docker-compose run --rm web rails rswag
