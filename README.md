# GA4-Attribution-Assessment-dbt-BigQuery

This project implements **First-Click** and **Last-Click attribution** using the GA4 public dataset in BigQuery, orchestrated with dbt. It also includes a small streaming demo and a dashboard prototype.


- **Source**: GA4 public dataset (`bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*`)
- **Warehouse**: BigQuery
- **Transformations**: dbt (staging, intermediate, marts)
- **Streaming Demo**: Python script -> BigQuery table
- **Dashboard**: Looker Studio connected to mart + streaming demo

## Attribution Assumptions
- **Conversion event**: `purchase`
- **Lookback window**: 90 days before conversion
- **Identity**: `user_pseudo_id` (fallback `session_id`)
- **Non-direct override**: if medium is `(none)` or `direct`, use most recent non-direct touch
- **Tie-breaker**: earliest/latest event_ts; break ties by ingestion order

## How to Run
1. **Install dbt BigQuery adapter**:
   ```bash
   pip install dbt-bigquery
   ```
2. **Auth to GCP**:
   ```bash
   gcloud auth application-default login
   ```
3. **Configure profile**:
   Copy `profiles.example.yml` to `~/.dbt/profiles.yml` and edit your GCP project.
4. **Run models**:
   ```bash
   dbt run
   dbt test
   dbt docs generate && dbt docs serve
