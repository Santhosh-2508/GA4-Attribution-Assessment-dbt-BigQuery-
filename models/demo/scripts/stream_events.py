import uuid
import random
import datetime
import json

# Allowed values for UTM fields
utm_sources = ["google", "facebook", "linkedin", "newsletter"]
utm_mediums = ["cpc", "email", "organic", "social"]
utm_campaigns = ["summer_sale", "launch2025", "retargeting", "branding"]
event_names = ["page_view", "add_to_cart", "purchase"]

rows_to_insert = []

for i in range(10):  # generate 10 events
    event = {
        "event_id": str(uuid.uuid4()),
        "user_pseudo_id": f"user_{random.randint(1,5)}",
        "event_name": random.choice(event_names),
        # timezone-aware UTC timestamp
        "event_ts": datetime.datetime.now(datetime.timezone.utc).isoformat(),
        "utm_source": random.choice(utm_sources),
        "utm_medium": random.choice(utm_mediums),
        "utm_campaign": random.choice(utm_campaigns),
        "gclid": str(uuid.uuid4())[:10]
    }
    rows_to_insert.append(event)

# Write NDJSON (one JSON object per line)
with open("events.json", "w") as f:
    for row in rows_to_insert:
        f.write(json.dumps(row) + "\n")

print("✅ Generated 10 events into events.json")
