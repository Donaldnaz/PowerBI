"""
Streaming Pub/Sub to BigQuery Pipeline

This Dataflow pipeline reads live JSON messages from a Pub/Sub topic, converts them into structured records, and continuously writes them
to a BigQuery table for real time analytics.
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
        'fields': [
            {'name': 'sensor_id', 'type': 'STRING'},
            {'name': 'temperature', 'type': 'FLOAT'},
            {'name': 'timestamp', 'type': 'TIMESTAMP'}
        ]
    }
    
    # Build pipeline
    with beam.Pipeline(options=options) as pipeline:
        (
            pipeline
            | "Read from Pub/Sub" >> ReadFromPubSub(
                topic="projects/PROJECT_ID/topics/sensor-temperature-topic"
            )
            | "Parse JSON" >> beam.ParDo(ParseJson())
            | "Write to BigQuery" >> WriteToBigQuery(
                table="PROJECT_ID:dataset.temperature_data",
                schema=schema,
                write_disposition=beam.io.BigQueryDisposition.WRITE_APPEND
            )
        )


if __name__ == "__main__":
    run()
