CREATE MATERIALIZED VIEW IF NOT EXISTS pulsehouse.mv_product_events
TO pulsehouse.product_events
AS
SELECT
    event_id,

    event_time,
    toDate(event_time) AS event_date,

    user_id,
    session_id,

    source,
    event_type,

    product_id,
    category,

    price,
    currency,

    ingestion_time,

    toUInt64(
        greatest(
            0,
            dateDiff(
                'millisecond',
                event_time,
                ingestion_time
            )
        )
    ) AS ingestion_delay_ms

FROM pulsehouse.raw_product_events;