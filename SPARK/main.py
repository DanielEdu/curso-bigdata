from pyspark.sql import SparkSession


    
spark = (
    SparkSession.builder
    .master('local[*]')
    .appName('my_spark_app')
    ).getOrCreate()

spark.sparkContext.setLogLevel('WARN')

# Leemos el archivo de datos en una variable
df_pokemon = (
    spark.read.format("csv")
    .option("header", "true")
    .option("inferSchema", "true")
    .load("./data/input/pokemon.csv")
    )

df_pokemon.show(5,False)


# Entry point for PySpark ETL application
spark.stop()
exit()