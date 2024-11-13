build:
	docker-compose build

bash:
	docker-compose run --rm --service-ports web /bin/bash

up:
	docker-compose up
