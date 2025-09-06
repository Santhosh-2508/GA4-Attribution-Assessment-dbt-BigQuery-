with events as (
  select * from {{ ref('stg_events') }}
),

first_touch as (
  select
    user_pseudo_id,
    min(event_ts) as first_event_ts,
    -- capture utm values from the first touch
    any_value(utm_source ignore nulls) as first_source,
    any_value(utm_medium ignore nulls) as first_medium,
    any_value(utm_campaign ignore nulls) as first_campaign,
    any_value(gclid ignore nulls) as first_gclid
  from events
  group by user_pseudo_id
)

select * from first_touch
