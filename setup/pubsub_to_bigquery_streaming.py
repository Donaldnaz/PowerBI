"""
Real Time Well Sensor Data Streaming into BigQuery

This Dataflow pipeline ingests live oilfield sensor data such as
wellhead temperature and facility telemetry from Pub/Sub,
processes it in real time, and stores it in BigQuery for
operational monitoring and analytics.
"""

import json
import apache_beam as beam
from apache_beam.options.pipeline_options import PipelineOptions
from apache_beam.io.gcp.pubsub import ReadFromPubSub
from apache_beam.io.gcp.bigquery import WriteToBigQuery


class ParseJson(beam.DoFn):
    """Parse JSON messages from Pub/Sub"""
    def process(self, element):
        record = json.loads(element.decode("utf-8"))
        yield record


def run():
    # Configure pipeline
    options = PipelineOptions(streaming=True, save_main_session=True)
    
    # BigQuery schema
    schema = {
        "fields": [
            {"name": "storage_site", "type": "STRING"},
            {"name": "injection_well", "type": "STRING"},
            {"name": "co2_injection_temperature_f", "type": "FLOAT"},
            {"name": "co2_injection_pressure_psi", "type": "FLOAT"},
        ]
    }
    
    # Build pipeline
    with beam.Pipeline(options=options) as pipeline:
        (
            pipeline
            | "Read from Pub/Sub" >> ReadFromPubSub(
                topic="projects/PROJECT_ID/topics/ccs-telemetry-topic"
            )
            | "Parse JSON" >> beam.ParDo(ParseJson())
            | "Write to BigQuery" >> WriteToBigQuery(
                table="PROJECT_ID:dataset.well_temperature_readings",
                schema=schema,
                write_disposition=beam.io.BigQueryDisposition.WRITE_APPEND
            )
        )


if __name__ == "__main__":
    run()
