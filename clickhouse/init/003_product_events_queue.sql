CREATE TABLE IF NOT EXISTS pulsehouse.product_events_queue
(
    event_id UUID,
    schema_version UInt16,

    event_time DateTime64(3, 'UTC'),

    user_id String,
    session_id String,

    source String,
    event_type String,

    payload Tuple(
        product_id String,
        category String,
        price Decimal(12, 2),
        currency String
    )
)
ENGINE = Kafka
SETTINGS
    kafka_broker_list = 'redpanda-0:9092,redpanda-1:9092,redpanda-2:9092',
    kafka_topic_list = 'product-events',
    kafka_group_name = 'pulsehouse-clickhouse-product-events',
    kafka_format = 'JSONEachRow',
    kafka_num_consumers = 1;
