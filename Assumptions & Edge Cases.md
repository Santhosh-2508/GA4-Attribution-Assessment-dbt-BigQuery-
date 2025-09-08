# Assumptions & Edge Cases

## Attribution Assumptions
- **Dataset**: bigquery-public-data.ga4_obfuscated_sample_ecommerce (2020–2021 GA4 sample data).  
- **Lookback window**: 90 days before conversion (default unless clarified).  
- **Identity priority**: `user_pseudo_id` (fallback = `ga_session_id`).  
- **Conversion event**: `purchase`.  
- **Revenue**: taken from event_params `value` if available.  

## Attribution Logic
- **First-Click**: earliest eligible non-direct touch in lookback window.  
- **Last-Click**: latest eligible non-direct touch before conversion.  
- **Non-direct override**: If medium is `(none)`/`direct`, use last preceding non-direct touch when available.  
- **Tie-breakers**: if multiple touches share same timestamp, pick the one with highest `source` alphabetically.  

## Streaming Demo Assumptions
- **Table**: `PROJECT.demo.events_streaming`.  
- **Event ID** ensures idempotency; duplicates are deduped using `ROW_NUMBER()`.  
- **Latency**: BigQuery streaming latency observed ~seconds to <2 minutes.  
- **Free Tier Limitation**: Direct streaming insert not supported → fallback to batch load via Python client.  

## Edge Cases
- Missing `utm_*` fields are treated as `Direct`.  
- Users without conversion events are excluded from mart tables.  
- If no eligible touch in lookback window → attribution marked as `Direct`.  
- GA4 public dataset is limited (demo only: 2020–2021 data). Dashboard metrics reflect only sample.  
