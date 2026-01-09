# Real Time Carbon Storage Monitoring Pipeline with BigQuery

**Author:** Anasieze Ikenna  
**Role:** Cloud & AI Engineer  
**Platform:** Google Cloud Platform  

---

## Project Overview

A real time Carbon Capture and Storage (CCS) telemetry pipeline that streams live sensor readings from CO₂ injection wells and surface facilities into BigQuery, enabling continuous monitoring and analytics of injection conditions.

This system replaces batch uploads with live telemetry ingestion, supporting modern CCS operations such as injection monitoring, integrity assurance, and data driven decision making for safe long term CO₂ storage.

---
## Problem Statement

Oil field engineers supporting CCS operations needed a solution to:

+	Ingest real time sensor data from CO₂ injection wells
+	Process continuous pressure and temperature data reliably at scale
+	Store CCS sensor data in an analytics ready data warehouse
+	Validate incoming field data as it arrives

My responsibility: I designed and implemented the end to end CCS telemetry streaming pipeline using Google Cloud managed services.

---

## Tech Stack

- **Cloud Storage** – temporary and staging storage for Dataflow job execution 
- **Pub/Sub** – real time ingestion of CCS telemetry events
- **Dataflow** – continuous stream processing of injection data
- **BigQuery** – analytics storage for querying, validation, and reporting

## Architecture Overview

<img width="5437" height="2355" alt="image" src="https://github.com/user-attachments/assets/882e7b7a-9eb5-406b-b335-a2324bb8c7b1" />

### Data Flow

1. CO₂ injection well sensors publish telemetry (e.g., pressure, rate and temperature) as JSON events
2. Pub/Sub ingests telemetry messages in real time  
3. Dataflow processes and streams telemetry continuously  
4. BigQuery stores processed records for analytics and reporting  
5. SQL queries validate incoming data and support operational analysis

This architecture is serverless, scalable, and aligned with modern CCS monitoring systems.

---

## Deployment Steps

### Prerequisites

- Google Cloud project with billing enabled  
- IAM roles:
  - Pub/Sub Admin  
  - Dataflow Admin  
  - BigQuery Admin  
  - Storage Admin  
- APIs enabled:
  - Pub/Sub  
  - Dataflow  
  - BigQuery  
  - Cloud Storage
---

### Configuration Variables

```bash
PROJECT_ID=<your-project-id>
REGION=us-central1

BUCKET_NAME=$PROJECT_ID
DATASET_NAME=ccs_monitoring
TABLE_NAME=co2_injection_telemetry
TOPIC_NAME=ccs-telemetry-topic
DATAFLOW_JOB_NAME=ccs-monitoring-stream
````
---

### Enable Required APIs

```bash
gcloud services enable \
  pubsub.googleapis.com \
  dataflow.googleapis.com \
  bigquery.googleapis.com \
  storage.googleapis.com
```

---

### Create Cloud Storage Bucket

```bash
gsutil mb -l $REGION gs://$BUCKET_NAME
gsutil mkdir gs://$BUCKET_NAME/temp
```

---

### Create BigQuery Dataset and Table

Create dataset:

```bash
bq mk --location=US $DATASET_NAME
```

Create table:

```bash
bq mk \
  --table \
  --schema storage_site:STRING,injection_well:STRING,co2_injection_temperature_f:FLOAT,co2_injection_pressure_psi:FLOAT,co2_injection_rate_tpd:FLOAT,timestamp:TIMESTAMP \
  $DATASET_NAME.$TABLE_NAME
```

---

### Create Pub/Sub Topic

```bash
gcloud pubsub topics create $TOPIC_NAME
```

---

### Run Dataflow Streaming Pipeline

```bash
gcloud dataflow jobs run $DATAFLOW_JOB_NAME \
  --gcs-location gs://dataflow-templates-$REGION/latest/PubSub_to_BigQuery \
  --region $REGION \
  --parameters \
inputTopic=projects/$PROJECT_ID/topics/$TOPIC_NAME,\
outputTableSpec=$PROJECT_ID:$DATASET_NAME.$TABLE_NAME,\
tempLocation=gs://$BUCKET_NAME/temp
```

Wait until the job status is **Running**.

---

### Publish Test Message

```bash
gcloud pubsub topics publish $TOPIC_NAME \
  --message='{
    "storage_site": "Hibernia_CCS",
    "injection_well": "INJ_03",
    "co2_injection_temperature_f": 121.4,
    "co2_injection_pressure_psi": 2950,
    "co2_injection_rate_tpd": 1800,
    "timestamp": "2026-01-08T15:20:00Z"
  }'

```
---

### Validate in BigQuery - Detect high pressure events

```sql
SELECT *
FROM `PROJECT_ID.ccs_monitoring.co2_injection_telemetry`
WHERE co2_injection_pressure_psi > 3200;

```

Replace `PROJECT_ID` with your actual project ID.

---

## Troubleshooting

If data does not appear in BigQuery:

* Confirm Dataflow job status is **Running**
* Publish another message and wait 30–60 seconds
* Check Dataflow logs for permission or schema errors
* Verify the correct region is used for the template

---

## Outcome
* A fully operational real time CCS monitoring pipeline
* Live CO₂ injection telemetry streaming continuously from Pub/Sub into BigQuery
* A reproducible, cloud native architecture suitable for carbon storage monitoring, operational oversight, and regulatory analysis

## Conclusion
In real CCS deployments, field sensors communicate through industrial protocols to an edge gateway. For this project, the gateway layer is simulated by publishing structured telemetry messages into Pub/Sub, allowing realistic design and testing of the cloud ingestion and analytics pipeline.

---

This project demonstrates my ability to design and implement a real time CCS telemetry pipeline on Google Cloud streams live injection well data into BigQuery for continuous monitoring, analytics, and operational insight, combining my oil and gas domain knowledge with cloud native data engineering.
