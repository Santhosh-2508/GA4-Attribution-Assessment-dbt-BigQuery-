[2025-09-05 10:00] Created repo and set up dbt project structure (staging, intermediate, marts).  
[2025-09-05 12:00] Wired GA4 public dataset as source (ga4.events_*), added stg_ga4_events model.  
[2025-09-05 15:00] Built intermediate int_touches model with channel classification macro.  
[2025-09-05 17:30] Added schema.yml with not_null/unique/accepted_values tests.  

[2025-09-06 09:30] Implemented mart_attribution (First-Click & Last-Click attribution logic).  
[2025-09-06 11:30] Added mart_attribution_per_user, mart_attribution_timeseries, mart_channel_breakdown.  
[2025-09-06 14:00] Debugged syntax errors in marts; verified successful dbt run.  
[2025-09-06 16:00] Implemented streaming demo table + Python script (stream_events.py).  

[2025-09-07 10:00] Ran streaming demo with 5–20 events; verified idempotency (reuse IDs).  
[2025-09-07 12:00] Connected Looker Studio to mart_attribution + streaming tables.  
[2025-09-07 14:00] Built dashboard: First vs Last totals, 14-day time series, channel breakdown, live events.  
[2025-09-07 16:00] Generated dbt docs, finalized architecture diagram, and wrote README & runbook.  
