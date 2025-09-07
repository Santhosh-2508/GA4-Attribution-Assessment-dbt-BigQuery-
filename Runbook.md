Mini pipeline on GCP/BigQuery + dbt. Models GA4 events → First/Last click attribution → Streaming demo → Dashboard.

How to Run

Locally

# Auth & setup
gcloud auth application-default login
pip install dbt-bigquery google-cloud-bigquery

# Run dbt
dbt run && dbt test
dbt docs generate

# Streaming demo
cd scripts
python stream_events.py --n 10


In GCP

Schedule dbt run via Cloud Composer / Cloud Scheduler.

Looker Studio dashboard reads marts + streaming tables.

Monitoring

dbt logs → target/run_results.json.

BigQuery UI → check job history.

Streaming lag:

select timestamp_diff(current_timestamp(), max(event_ts), second) as lag_sec 
from demo.events_streaming;

Failures & Fixes

❌ Profile not found → Fix ~/.dbt/profiles.yml.

❌ Dataset not found → bq mk --dataset project:dataset.

❌ Streaming insert blocked → enable billing or switch to batch load.

❌ Dashboard empty → rerun dbt run + refresh data source.

Cost Notes

GA4 public dataset free (within limits).

Streaming inserts need billing.

Use partitions & clustering to cut query costs.