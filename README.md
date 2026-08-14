# Pulsehouse

Minimal local data stack with Redpanda and ClickHouse.

## Services

- Redpanda Kafka API: `localhost:19092`
- Redpanda admin API: `localhost:9644`
- ClickHouse HTTP: `localhost:8123`
- ClickHouse native: `localhost:9000`

ClickHouse initializes a `pulsehouse` database from `clickhouse/init/001_database.sql`.

## Requirements

- Docker
- Docker Compose
- Make

## Usage

Start the stack:

```sh
make up
```

Show running services:

```sh
make ps
```

Open a ClickHouse client:

```sh
make clickhouse
```

Follow logs:

```sh
make logs
```

Stop the stack:

```sh
make down
```

Remove containers and volumes:

```sh
make clean
```
