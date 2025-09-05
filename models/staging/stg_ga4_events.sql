{{ config(materialized='view') }}

with src as (
  select
    _table_suffix as event_date,
    user_pseudo_id,
    (select value.int_value from unnest(event_params)
      where key='ga_session_id') as ga_session_id,
    event_name,
    timestamp_micros(event_timestamp) as event_ts,
    (select value.string_value from unnest(event_params) where key='source')  as utm_source,
    (select value.string_value from unnest(event_params) where key='medium')  as utm_medium,
    (select value.string_value from unnest(event_params) where key='campaign') as utm_campaign,
    (select value.string_value from unnest(event_params) where key='gclid') as gclid,
    -- add revenue if available; else leave null
    (select value.int_value from unnest(event_params) where key='value') as value
  from {{ source('ga4','events') }}
)
select * from src


