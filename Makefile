.PHONY: up down restart logs ps clean clickhouse consume-products connect-logs raw-count raw-events kafka-consumers domain-count domain-events event-stats ingestion-latency

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

consume-products:
	docker compose exec redpanda \
		rpk topic consume product-events

connect-logs:
	docker compose logs -f redpanda-connect


raw-count:
	docker compose exec clickhouse \
		clickhouse-client \
		--query "SELECT count() FROM pulsehouse.raw_product_events"

raw-events:
	docker compose exec clickhouse \
		clickhouse-client \
		--query "SELECT * FROM pulsehouse.raw_product_events ORDER BY event_time DESC LIMIT 10"

kafka-consumers:
	docker compose exec clickhouse \
		clickhouse-client \
		--query "SELECT * FROM system.kafka_consumers FORMAT Vertical"

domain-count:
	docker compose exec clickhouse \
		clickhouse-client \
		--query "SELECT count() FROM pulsehouse.product_events"

domain-events:
	docker compose exec clickhouse \
		clickhouse-client \
		--query "SELECT * FROM pulsehouse.product_events ORDER BY event_time DESC LIMIT 10"

event-stats:
	docker compose exec clickhouse \
		clickhouse-client \
		--query "SELECT event_type, count() events FROM pulsehouse.product_events GROUP BY event_type ORDER BY events DESC"

ingestion-latency:
	docker compose exec clickhouse \
		clickhouse-client \
		--query "SELECT round(avg(ingestion_delay_ms),2) avg_ms, round(quantile(0.95)(ingestion_delay_ms),2) p95_ms FROM pulsehouse.product_events"