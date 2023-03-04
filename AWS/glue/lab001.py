
import pyspark.sql.functions as f

#Leemos los datos
dfTransaccion = spark.sql("SELECT * FROM db.table")

#Procesamos
df_reporte = dfTransaccion.groupBy(dfTransaccion["c1"]).agg(
    f.count(dfTransaccion["c2"]),
    f.sum(dfTransaccion["c3"])
)

#Almacenamos el dataframe como vista temporal
df_reporte.createOrReplaceTempView("df_reporte_vw")

#Lo guardamos en la tabla
spark.sql("""
    INSERT INTO db.table
    SELECT
        T.*
    FROM df_reporte_vw T
""")