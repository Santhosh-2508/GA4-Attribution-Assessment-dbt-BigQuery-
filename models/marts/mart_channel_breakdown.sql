{{ config(materialized='table') }}

with first_counts as (
  select first_click_channel as channel, count(*) as first_count
  from {{ ref('mart_attribution') }}
  group by 1
),
last_counts as (
  select last_click_channel as channel, count(*) as last_count
  from {{ ref('mart_attribution') }}
  group by 1
)

select
  coalesce(f.channel, l.channel) as channel,
  coalesce(f.first_count,0) as first_count,
  coalesce(l.last_count,0) as last_count
from first_counts f
full outer join last_counts l
  on f.channel = l.channel
order by greatest(coalesce(f.first_count,0), coalesce(l.last_count,0)) desc
