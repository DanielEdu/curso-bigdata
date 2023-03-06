# https://spark.apache.org/docs/latest/structured-streaming-programming-guide.html
from pyspark.sql import SparkSession
from pyspark.sql.types import *
import pyspark.sql.functions as f
from schemas import sch_json


spark = (
    SparkSession.builder
    .master('local[*]')
    .appName('spark_streaming_app')
    ).getOrCreate()

spark.sparkContext.setLogLevel('WARN')

dfStream = spark.readStream.format("kafka").\
option("kafka.bootstrap.servers", "localhost:9092").\
option("subscribe", "quickstart-events").\
option("startingOffsets", "latest").\
load()


dfStream_cast = dfStream.select(dfStream['value'].cast('string'), dfStream['offset'], dfStream['timestamp'])
df = (dfStream_cast
      .withColumn('json_data', f.from_json(dfStream_cast['value'], schema=sch_json))
      .select('json_data','offset','timestamp','json_data.message')
    )

query = (df
    .writeStream
    .outputMode("update")
    .trigger(processingTime="5 seconds")
    .format("console")
    .option('truncate', False)
    .start()
)

query.awaitTermination()