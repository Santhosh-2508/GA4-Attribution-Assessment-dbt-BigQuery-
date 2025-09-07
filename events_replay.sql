{{ config(materialized='table') }}

{% set start_date = var('start_date', '20210101') %}
{% set end_date   = var('end_date', '20210107') %}

with source as (
    select *
    from {{ ref('stg_ga4_events') }}
    -- GA4 event_date is string (YYYYMMDD), so vars must match that format
    where event_date between '{{ start_date }}' and '{{ end_date }}'
)

select
    *,
    timestamp_add(
      event_ts,
      interval timestamp_diff(current_date(), date('2021-01-01'), day) day
    ) as simulated_event_ts
from source
