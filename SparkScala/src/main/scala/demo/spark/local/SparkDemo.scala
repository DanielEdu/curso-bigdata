package demo.spark.local
import org.apache.log4j.{Level, Logger}
import org.apache.spark.sql.{DataFrame, SparkSession}
import org.apache.spark.sql.functions.{col, desc, sum}


object SparkDemo {
  def main(args: Array[String]): Unit = {

    val spark: SparkSession = SparkSession.builder
      .master("local[*]")
      .appName("SparkDemo")
      .getOrCreate()
    spark.sparkContext.setLogLevel("WARN")

    println("Hello, SparkDemo")

    val sparkVersion = spark.version
    val scalaVersion = util.Properties.versionNumberString
    val javaVersion = System.getProperty("java.version")

    println("SPARK VERSION = " + sparkVersion)
    println("SCALA VERSION = " + scalaVersion)
    println("JAVA  VERSION = " + javaVersion)

    val df = read_data(spark,"/tmp/data/pokemon.csv")
    df.show(5,truncate = false)

    // close Spark
    spark.close()
  }



  def read_data(spark: SparkSession, path: String): DataFrame = {
    val df = spark.read.format("csv")
      .option("header", "true")
      .option("inferSchema", "true")
      .load(path)

    return df

  }

}
