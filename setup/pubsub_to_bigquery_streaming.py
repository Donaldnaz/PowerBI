"""
Real Time CCS Telemetry Streaming into BigQuery

This Dataflow pipeline ingests live Carbon Capture and Storage (CCS)
telemetry such as CO₂ injection temperature and pressure from Pub/Sub,
processes it in real time, and stores it in BigQuery for continuous
monitoring, analytics, and operational oversight.
"""

import json
import apache_beam as beam
from apache_beam.options.pipeline_options import PipelineOptions
from apache_beam.io.gcp.pubsub import ReadFromPubSub
from apache_beam.io.gcp.bigquery import WriteToBigQuery


class ParseJson(beam.DoFn):
    """Parse JSON telemetry messages from Pub/Sub"""
    def process(self, element):
        record = json.loads(element.decode("utf-8"))

        # Attach ingestion timestamp if not present
        record.setdefault("timestamp", beam.utils.timestamp.Timestamp.now().to_rfc3339())

        yield record


def run():
    # Configure pipeline for streaming execution
    options = PipelineOptions(streaming=True, save_main_session=True)

    # BigQuery schema for CCS telemetry
    schema = {
        "fields": [
            {"name": "storage_site", "type": "STRING"},
            {"name": "injection_well", "type": "STRING"},
            {"name": "co2_injection_temperature_f", "type": "FLOAT"},
            {"name": "co2_injection_pressure_psi", "type": "FLOAT"},
            {"name": "timestamp", "type": "TIMESTAMP"},
        ]
    }

    # Build streaming pipeline
    with beam.Pipeline(options=options) as pipeline:
        (
            pipeline
            # Read real time CCS telemetry events from Pub/Sub
            | "Read from Pub/Sub" >> ReadFromPubSub(
                topic="projects/PROJECT_ID/topics/ccs-telemetry-topic"
            )
            # Parse incoming JSON messages into structured records
            | "Parse JSON" >> beam.ParDo(ParseJson())
            # Write telemetry records into BigQuery for analytics
            | "Write to BigQuery" >> WriteToBigQuery(
                table="PROJECT_ID:ccs_monitoring.co2_injection_telemetry",
                schema=schema,
                write_disposition=beam.io.BigQueryDisposition.WRITE_APPEND,
                create_disposition=beam.io.BigQueryDisposition.CREATE_NEVER,
            )
        )


if __name__ == "__main__":
    run()
