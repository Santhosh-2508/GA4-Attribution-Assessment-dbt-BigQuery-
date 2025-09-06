{{ config(materialized='view') }}

select
    event_id,
    user_pseudo_id,
    event_name,
    cast(event_ts as timestamp) as event_ts,
    utm_source,
    utm_medium,
    utm_campaign,
    gclid
from {{ source('demo', 'events_streaming') }}
