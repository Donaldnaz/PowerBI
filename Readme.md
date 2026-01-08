# Real Time Oilfield Telemetry Streaming into BigQuery

**Author:** Anasieze Ikenna  
**Role:** Cloud & AI Engineer  
**Platform:** Google Cloud Platform  

---

## Project Overview

A real time data pipeline that streams live oilfield sensor readings from wells and production facilities into BigQuery, enabling continuous monitoring and analytics of field conditions.

This system replaces batch uploads with live data ingestion, supporting modern digital oilfield operations and data driven decision making.

---

## Problem Statement

A newly formed development team needed a cloud native solution to:

- Ingest real time oilfield sensor data from wells and surface facilities  
- Process continuous telemetry streams reliably at scale  
- Store data in an analytics ready warehouse for operational insights  
- Validate incoming field data as it arrives  

**My responsibility:**  I designed and implemented the end to end streaming telemetry pipeline using Google Cloud managed services.

---

## Tech Stack

- **Cloud Storage** – temporary and staging storage for Dataflow job execution 
- **Pub/Sub** – real time ingestion of oilfield telemetry events  
- **Dataflow** – continuous stream processing of sensor data  
- **BigQuery** – analytics storage for querying and validation


## Architecture Overview

<img width="6449" height="940" alt="image" src="https://github.com/user-attachments/assets/87036e4a-d758-48de-8a01-dfe87a718c76" />

### Data Flow

1. Oilfield sensors publish telemetry data (e.g., temperature readings) as JSON events  
2. Pub/Sub ingests sensor messages in real time  
3. Dataflow processes and streams telemetry continuously  
4. BigQuery stores processed records for analytics and reporting  
5. SQL queries validate incoming data and support operational analysis

This architecture is **serverless**, **scalable**, and **production aligned**.

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
DATASET_NAME=oilfield_telemetry
TABLE_NAME=well_temperature_readings
TOPIC_NAME=oilfield-sensor-topic
DATAFLOW_JOB_NAME=oilfield-telemetry-stream
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
  $DATASET_NAME.$TABLE_NAME \
  data:STRING
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
  --message='{"data": "73.4 F"}'
```

---

### Validate in BigQuery

```sql
SELECT *
FROM `PROJECT_ID.oilfield_telemetry.well_temperature_readings`
LIMIT 50;
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

* A fully operational real time oilfield telemetry streaming pipeline
* Live sensor data flowing continuously from Pub/Sub into BigQuery
* A reproducible, cloud native architecture suitable for digital oilfield analytics
---

This project demonstrates how real time oilfield telemetry can be ingested, processed, and analyzed using cloud native streaming pipelines, enabling modern oil and gas operations to gain faster operational insights and improve decision making.
