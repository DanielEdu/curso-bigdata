# Glue Jobs

## IAM Role para Glue

1. crear IAM Role para un servicio de AWS (glue)
2. buscar el servicio de Glue y agregarlo, next.
3. en el apartado Add permissions buscar y agregar `AWSGlueServiceRole` y `AmazonS3FullAccess`, Next.
4. Poner nombre y crear.

## crear job con la interfaz grafica de Glue Studio (Blank canvas)

1. Seleccionar Visual with a blank canvas y dar a Create.
2. Escoger y configurar un source del tipo `AWS Glue Data Catalog`.
3. Escoger y configurar una transformacion `Select Fields`.
4. Escoger y configurar una salida del tipo `AWS Glue Data Catalog`.
5. Ir a Job Details y configurar
    - job bookmark desable.
    - Request number of workers 2 para acceder a capa gratuita
6. RUN
7. monitoring

## Crear un job con Script Spark

1. Seleccionar *Spark script editor*
2. 