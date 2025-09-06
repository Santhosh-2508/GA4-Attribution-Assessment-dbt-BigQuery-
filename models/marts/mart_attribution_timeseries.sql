{{ config(materialized='table') }}

select
  date(conversion_ts) as conversion_date,
  count(*) as conversions,
  countif(first_click_channel is not null) as conversions_with_first,
  countif(last_click_channel is not null) as conversions_with_last
from {{ ref('mart_attribution') }}
where date(conversion_ts) >= date_sub(current_date(), interval 13 day)  -- last 14 days
group by conversion_date
order by conversion_date
