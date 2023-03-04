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


df1 = df_pokemon.filter(df_pokemon["Legendary"] == True)
df1.show()

df1.write.format("csv") \
    .mode("overwrite") \
    .option("header", "true") \
    .save("/tmp/data/out")


spark.stop()
exit()