
import pyspark.sql.functions as f

#Leemos los datos
dfTransaccion = spark.sql("SELECT * FROM landing.transactions")

#Almacenamos el dataframe como vista temporal
dfTransaccion.createOrReplaceTempView("dfTransaccion")

#guardamos en la tabla
spark.sql("""
    INSERT INTO bronze.transactions
    SELECT
        id_persona,
	    id_empresa,
	    cast(monto as double) as monto,
	    fecha
    FROM dfTransaccion T
""")