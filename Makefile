SHELL := /bin/bash

include .env
export

wait-for-postgres:
	@until docker compose ps -q db && \
		docker compose exec -T db pg_isready; do \
		sleep 1; \
	done

restart-server:
	docker compose down -v && docker compose up -d

stop-server:
	docker compose down -v

populate-db: restart-server wait-for-postgres
	cat my_database.sql | docker compose exec -T db psql -U $$POSTGRES_USER -d $$POSTGRES_DB