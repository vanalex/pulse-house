.PHONY: up down restart logs ps clean clickhouse

up:
	docker compose up -d

down:
	docker compose down

restart:
	docker compose restart

logs:
	docker compose logs -f

ps:
	docker compose ps

clickhouse:
	docker compose exec clickhouse clickhouse-client

clean:
	docker compose down -v
