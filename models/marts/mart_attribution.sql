{{ config(materialized='table') }}

with conversions as (
  select 
    user_pseudo_id, 
    event_ts as conversion_ts
  from {{ ref('stg_ga4_events') }}
  where event_name = 'purchase'
),

eligible_touches as (
  select
    c.user_pseudo_id,
    c.conversion_ts,
    t.channel,
    t.event_ts as touch_ts
  from conversions c
  join {{ ref('int_touches') }} t
    on t.user_pseudo_id = c.user_pseudo_id
   and t.event_ts between timestamp_sub(c.conversion_ts, interval 90 day) and c.conversion_ts
),

first_click as (
  select * from (
    select 
      *, 
      row_number() over(
        partition by user_pseudo_id, conversion_ts 
        order by touch_ts asc
      ) as rn
    from eligible_touches
  ) 
  where rn = 1
),

last_click as (
  select * from (
    select 
      *, 
      row_number() over(
        partition by user_pseudo_id, conversion_ts 
        order by touch_ts desc
      ) as rn
    from eligible_touches
  ) 
  where rn = 1
)

select
  c.user_pseudo_id,
  c.conversion_ts,
  f.channel as first_click_channel,
  l.channel as last_click_channel
from conversions c
left join first_click f 
  using(user_pseudo_id, conversion_ts)
left join last_click l 
  using(user_pseudo_id, conversion_ts)
