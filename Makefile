restartdb:
	docker compose down db -v && docker compose up db -d