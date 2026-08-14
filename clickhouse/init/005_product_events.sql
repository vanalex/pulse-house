CREATE TABLE IF NOT EXISTS pulsehouse.product_events
(
    event_id UUID,

    event_time DateTime64(3, 'UTC'),
    event_date Date,

    user_id String,
    session_id String,

    source LowCardinality(String),
    event_type LowCardinality(String),

    product_id String,
    category LowCardinality(String),

    price Decimal(12, 2),
    currency LowCardinality(String),

    ingestion_time DateTime64(3, 'UTC'),

    ingestion_delay_ms UInt64
)
ENGINE = MergeTree
PARTITION BY toYYYYMM(event_date)
ORDER BY
(
    event_date,
    event_type,
    category,
    event_time,
    user_id
);