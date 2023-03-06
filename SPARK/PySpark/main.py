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
    .load("/Users/Shared/data/pokemon.csv")
    )

df_pokemon.show(5,False)

####
df_json = (
    spark.read.format("json")
    .option("inferSchema", "true")
    .load("/Users/Shared/data/data_test.json")
    )

df_json.show(3, False)
df_json.printSchema()
print(df_json.schema)

df1 = df_pokemon.filter(df_pokemon["Legendary"] == True)
df1.show()

def write_df(df):
    df1.write.format("csv") \
        .mode("overwrite") \
        .option("header", "true") \
        .save("/tmp/data/out")


spark.stop()
exit()