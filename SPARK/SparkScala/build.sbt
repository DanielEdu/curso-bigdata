name := "SparkDemos"
version := "0.1"
scalaVersion := "2.12.15"


libraryDependencies ++= {
  val sparkV = "3.3.2"
  val hadoopV = "3.3.2"

  Seq(
    "org.apache.spark" %% "spark-core" % sparkV,
    "org.apache.spark" %% "spark-sql" % sparkV,
    "org.apache.spark" %% "spark-streaming" % sparkV,
    "org.apache.hadoop" % "hadoop-common" % hadoopV,
    "org.apache.hadoop" % "hadoop-client" % hadoopV
  )
}