
-- Creamos la base de datos
CREATE DATABASE IF NOT EXISTS landing   LOCATION 's3://datalake-grupo01/landing';
CREATE DATABASE IF NOT EXISTS bronze    LOCATION 's3://datalake-grupo01/bronze';
CREATE DATABASE IF NOT EXISTS silver    LOCATION 's3://datalake-grupo01/silver';
CREATE DATABASE IF NOT EXISTS gold      LOCATION 's3://datalake-grupo01/gold';



-- creamos la tabla para empresas
CREATE EXTERNAL TABLE landing.companies(
	id_empresa string,
	empresa_name string
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
STORED AS TEXTFILE
LOCATION 's3://datalake-grupo01/landing/companies'
TBLPROPERTIES(
    'skip.header.line.count'='1',
    'store.charset'='ISO-8859-1', 
    'retrieve.charset'='ISO-8859-1'
);

-- Imprimimos los datos para verificar
SELECT * FROM landing.companies;


-- Creamos la tabla para la de transacciones
CREATE EXTERNAL TABLE landing.TRANSACCION(
	ID_PERSONA STRING,
	ID_EMPRESA STRING,
	MONTO STRING,
	FECHA STRING
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY '|'
LINES TERMINATED BY '\n'
STORED AS TEXTFILE
LOCATION 's3://datalake-grupo01/landing/transaccion'
TBLPROPERTIES(
    'skip.header.line.count'='1',
    'store.charset'='ISO-8859-1', 
    'retrieve.charset'='ISO-8859-1'
);

-- Imprimimos los datos para verificar
SELECT * FROM landing.TRANSACCION;



------------- BRONZE  -------------

-- Creamos la tabla en bronze
CREATE EXTERNAL TABLE bronze.companies(
    id_empresa string,
	empresa_name string
)
STORED AS PARQUET
LOCATION 's3://datalake-grupo01/bronze/companies'
TBLPROPERTIES(
    'store.charset'='ISO-8859-1', 
    'retrieve.charset'='ISO-8859-1'
);



-- insertar datos de landing a Bronze
INSERT INTO bronze.companies
SELECT 
    cast(id_empresa as bigint) as id_empresa,
    empresa_name
from landing.companies;

----

-- Creamos la tabla en bronze
CREATE EXTERNAL TABLE bronze.transaccion(
    ID_PERSONA STRING,
	ID_EMPRESA STRING,
	MONTO DOUBLE,
	FECHA STRING
)
STORED AS PARQUET
LOCATION 's3://datalake-grupo01/bronze/transaccion'
TBLPROPERTIES(
    'store.charset'='ISO-8859-1', 
    'retrieve.charset'='ISO-8859-1'
);
