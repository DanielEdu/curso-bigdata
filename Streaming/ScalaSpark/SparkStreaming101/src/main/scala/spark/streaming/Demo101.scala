package spark.streaming
import org.apache.spark.sql.streaming.Trigger
import org.apache.spark.sql.{DataFrame, SparkSession}
import org.apache.spark.sql.functions.{from_json, col}
import org.apache.spark.sql.functions.{col, desc, sum}
import org.apache.spark.sql.types.{StructType, StructField}
import org.apache.spark.sql.types.{StringType, IntegerType, DoubleType, LongType}
import Utils.{sparkInfo, sch_json}


object Demo101 extends  App {

  val spark: SparkSession = SparkSession.builder
    .master("local[*]")
    .appName("SparkStreamingDemo")
    .getOrCreate()
  spark.sparkContext.setLogLevel("WARN")

  sparkInfo(spark)


  val dfStream = spark.readStream.format("kafka").
    option("kafka.bootstrap.servers", "localhost:9092").
    option("subscribe", "quickstart-events").
    option("startingOffsets", "latest").
    load()


  val dfStream_cast = dfStream.select(
    col("value").cast("string"),
    col("offset"),
    col("timestamp")
  )


  val df_final = dfStream_cast
    .withColumn("json_Data", from_json(col("value"),sch_json))
    .drop("value")


  val query = (df_final
    .writeStream
    .outputMode("update")
    .trigger(Trigger.ProcessingTime("5 seconds"))
    .option("truncate", value = false)
    .format("console")
    .start()
  )

  query.awaitTermination()

}
