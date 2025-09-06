with events as (
  select * from {{ ref('stg_events') }}
),

last_touch as (
  select
    user_pseudo_id,
    max(event_ts) as last_event_ts,
    -- capture utm values from the last touch
    any_value(utm_source ignore nulls) as last_source,
    any_value(utm_medium ignore nulls) as last_medium,
    any_value(utm_campaign ignore nulls) as last_campaign,
    any_value(gclid ignore nulls) as last_gclid
  from events
  group by user_pseudo_id
)

select * from last_touch
