# Real Time Streaming Analytics into BigQuery

**Author:** Anasieze Ikenna  
**Role:** Cloud & AI Engineer  
**Platform:** Google Cloud Platform  

---

## Project Overview

This project demonstrates the design and deployment of a **real time streaming analytics pipeline** on Google Cloud. The system ingests live environmental sensor data, processes it continuously, and stores it in **BigQuery** for immediate querying and analysis.

Instead of relying on batch jobs or manual uploads, this architecture enables **continuous data flow**, making it suitable for use cases such as IoT sensors, monitoring systems, and real time analytics dashboards.

---

## Problem Statement

A newly formed development team required a solution to:

- Ingest real time temperature data from sensors  
- Process streaming events reliably at scale  
- Store data in an analytics ready warehouse  
- Validate incoming data instantly  

**My responsibility:**  
I designed and implemented the end to end streaming pipeline using Google Cloud managed services.

---

## Tech Stack

- **Cloud Storage** – temporary and staging storage for Dataflow jobs  
- **Pub/Sub** – real time event ingestion  
- **Dataflow** – continuous stream processing  
- **BigQuery** – analytics storage and validation  

---

## Architecture Overview

<img width="10665" height="2831" alt="image" src="https://github.com/user-attachments/assets/65d4bbc9-661c-44be-b606-9db80921ce5a" />

### Data Flow

1. Environmental sensor data is published as JSON events  
2. Pub/Sub ingests messages in real time  
3. Dataflow processes the streaming events continuously  
4. BigQuery stores processed records for analytics  
5. SQL queries validate and analyze incoming data  

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
  - 
---

### Configuration Variables

```bash
PROJECT_ID=<your-project-id>
REGION=us-central1

BUCKET_NAME=$PROJECT_ID
DATASET_NAME=sensor_streaming
TABLE_NAME=temperature_readings
TOPIC_NAME=sensor-temperature-topic
DATAFLOW_JOB_NAME=pubsub-to-bigquery-stream
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

Create dataset in US multi region:

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
FROM `PROJECT_ID.sensor_streaming.temperature_readings`
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

* A fully operational real time streaming analytics pipeline
* Live data flowing continuously from Pub/Sub into BigQuery
* A reproducible, cloud native architecture ready for extension

---

This project proves I can design, deploy, and operate real time cloud data pipelines, troubleshoot distributed systems independently, and think end to end like a cloud engineer.

