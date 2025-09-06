{{ config(materialized='table') }}

select
  user_pseudo_id,
  first_click_channel,
  count(*) as conversions_first_click,
  last_click_channel,
  count(*) over(partition by user_pseudo_id, last_click_channel) as conversions_last_click
from {{ ref('mart_attribution') }}
group by user_pseudo_id, first_click_channel, last_click_channel
