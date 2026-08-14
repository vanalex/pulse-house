CREATE TABLE IF NOT EXISTS pulsehouse.raw_product_events
(
    event_id UUID,
    schema_version UInt16,

    event_time DateTime64(3, 'UTC'),
    ingestion_time DateTime64(3, 'UTC') DEFAULT now64(3),

    user_id String,
    session_id String,

    source LowCardinality(String),
    event_type LowCardinality(String),

    product_id String,
    category LowCardinality(String),
    price Decimal(12, 2),
    currency LowCardinality(String)
)
ENGINE = MergeTree
PARTITION BY toYYYYMM(event_time)
ORDER BY
(
    event_type,
    event_time,
    user_id,
    event_id
);