# AWS Lambda

## AWS Lambda Layer

1. Acceda a la versión >=2.20.0 de la biblioteca de AWS Data Wrangler en GitHub en <https://github.com/awslabs/aws-data-wrangler/releases>. En Activos , descargue el archivo `awswrangler-layer-2.20.0-py3.9.zip` (o versión superior) en su disco local.
2. Inicie sesión en la Consola de administración de AWS como el usuario administrativo que creó.
3. Asegúrese de estar en la región que ha elegido para realizar las secciones prácticas `us-east-1`.
4. En la barra de búsqueda superior de la consola de AWS, busque y seleccione el servicio *Lambda*.
5. En elmenú de la izquierda, en *Additional Resources*, seleccione *Layers*, y click en *Create layer*.
6. Proporcione un nombre para la capa (por ejemplo, `awsDataWrangler220_python39` ), luego cargue el archivo `.zip` que descargó de GitHub. Para *Compatible runtimes*: opcional, seleccione Python 3.9 y luego haga clic en Crear.
    La siguiente captura de pantalla muestra la configuración para este paso:

    ![Descripción de la imagen](/AWS/img/lambda001.png)

## Creación de una política y un rol de IAM para su función de Lambda

En esta sección, estamos configurando un Lambdafunción que se activará cada vez que se cargue un nuevo archivo en un bucket específico de Amazon S3. Para que esto funcione, debemos asegurarnos de que nuestra función Lambda tenga los siguientes permisos:

- Lea nuestro depósito S3 de origen.
- Escribir en nuestro depósito S3 de destino.
- Escribir logs en Amazon CloudWatch.
- Acceso a todas las acciones de la API de Glue (para habilitar la creación de nuevas bases de datos y tablas).

Para crear un nuevo rol de AWS IAM con estos permisos, siga estos pasos:

1. Seleccione el servicio IAM y, en el menú de la izquierda, seleccione Políticas y luego haga clic en Crear política.
2. De forma predeterminada, la pestaña del editor visual está seleccionada, así que haga clic en JSON para cambiar a la pestaña JSON.
3. Remplaze la politica existente por la siguente (*asegurese de cambiar el nombre de los buckets*).

    ```json
    {
        "Version": "2012-10-17",
        "Statement": [
            {
                "Effect": "Allow",
                "Action": [
                    "logs:PutLogEvents",
                    "logs:CreateLogGroup",
                    "logs:CreateLogStream"
                ],
                "Resource": "arn:aws:logs:*:*:*"
            },
            {
                "Effect": "Allow",
                "Action": ["s3:*"],
                "Resource": [
                    "arn:aws:s3:::datalake-grupo2/*",
                    "arn:aws:s3:::datalake-grupo2"
                ]
            },
            {
                "Effect": "Allow",
                "Action": ["glue:*"],
                "Resource": "*"
            }
        ]
    }
    ```

4. Next. Proporcione un nombre para la política, como `DataEngLambdaS3CWGluePolicy` y luego haga click en Crear política.
5. En el menú de la izquierda haga click en ***Roles*** y luego ***Create role***.
6. seleccione ***AWS Service*** luego escoja ***Lambda*** y click en Next.
7. busque la politica que creó en el paso 4 (`DataEngLambdaS3CWGluePolicy`) y Next.
8. Proporcione un nombre como `DataEngLambdaS3CWGlueRole` y click en ***Create Rol***.

## Crear una Lambda Function

Ahora estamos listos para crear nuestra función Lambda que se activará cada vez que se abra un archivo CSV.cargado en nuestro depósito S3 de origen. El archivo CSV cargado se convertirá a Parquet, se escribirá en el depósito de destino y se agregará al catálogo de Glue mediante AWS Data Wrangler:

1. Seleccione el servicio Lambda y, en el menú de la izquierda, seleccione *Functions* y luego haga click en *create function*.

2. Seleccione *Author from scratch* y proporcione un nombre de función (como `CSVtoParquetLambda` ).
3. Escoja el Runtime ***Python 3.9***
4. Escoja *Use an existenting rol* y seleccione el rol que creó `DataEngLambdaS3CWGlueRole`.
5. Click **Create Function**.
6. Click en la caja *Layers*, lo llevará a la sección Layers, Click en *add a layer* y escoja la layer creada al inicio. Escoja la ultima versión y click en **Add*.
7. En el editor de código reemplazamos el código existente por el código del archivo `./lambda/CSVtoParquetLambda.py`
8. Click en **Deploy**.
9. Click en la pestaña *Configuration* y en la opción *general configuration*. Click en editar y cambie el timeout de 3s a 1m.

## Configurar nuestra función Lambda para que se active con una carga de S3

configurar la función Lambda para que cada vez que se cargue un archivo CSV a nuestro bucket de la zona landing, la función Lambda se ejecuta y convierte el archivo a formato Parquet.

1. En el cuadro *Function Overview*, haga clic en ***Add Trigger***.
2. Seleccione el servicio Amazon S3 de la lista desplegable.
3. Para Buckets, seleccione su depósito.
4. Queremos que nuestra regla se active cada vez que se cree un nuevo archivo en este depósito, sin importar qué método se use para crearlo ( Put , Post o Copy ), así que seleccione ***All object create events*** de la lista.
5. en *Prefix* peude escoger una carpeta interna del bucket
6. Para el *Suffix* , ingrese `.csv`. Para que solo ejecute la función Lambda cuando se cargue un archivo con una extensión .csv.

    ![Descripción de la imagen](/AWS/img/lambda002.png)
7. Click en **Add**.
8. rear unarchivo CSV simple llamado `test.csv`. Asegúrese de que la primera línea tenga encabezados de columna, como en el siguiente ejemplo:

    ```csv
    nombre,numero_favorito
    Gareth, 23
    Tracy, 28
    Cris,16
    Emma,14
    ```

9. Cargue su archivo de prueba en su depósito S3 de origen:

    ```bash
    aws s3 cp test.csv s3://datalake-grupo2/landing/tests/
    ```

10. PAra comprobar la carga vaya al Catalogo de Glue o al servicio de Athena para explorar la tabla creada.
    ![Descripción de la imagen](/AWS/img/lambda003.png)
