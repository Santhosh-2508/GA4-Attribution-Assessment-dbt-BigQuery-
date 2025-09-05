{{ config(materialized='table') }}

select
  user_pseudo_id,
  coalesce(cast(ga_session_id as string), 'no_session') as session_id,
  event_ts,
  event_name,
  utm_source,
  utm_medium,
  utm_campaign,
  gclid,
  case
    when gclid is not null or lower(utm_medium) in ('cpc','ppc','paidsearch') then 'Paid Search'
    when lower(utm_medium) = 'email' then 'Email'
    when lower(utm_medium) in ('social','paid_social') then 'Social'
    when lower(utm_medium) in ('(none)','direct') then 'Direct'
    else 'Other'
  end as channel   -- ✅ END properly closed, no semicolon here
from {{ ref('stg_ga4_events') }}
