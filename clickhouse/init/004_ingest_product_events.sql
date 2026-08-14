CREATE MATERIALIZED VIEW IF NOT EXISTS pulsehouse.mv_ingest_product_events
TO pulsehouse.raw_product_events
AS
SELECT
    event_id,
    schema_version,

    event_time,
    now64(3) AS ingestion_time,

    user_id,
    session_id,

    source,
    event_type,

    payload.product_id AS product_id,
    payload.category AS category,
    payload.price AS price,
    payload.currency AS currency

FROM pulsehouse.product_events_queue;