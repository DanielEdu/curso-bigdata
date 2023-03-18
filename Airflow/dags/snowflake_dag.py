from __future__ import annotations
import datetime
import pendulum
from airflow import DAG
from airflow.operators.empty import EmptyOperator
from airflow.contrib.operators.snowflake_operator import SnowflakeOperator



with DAG(
    dag_id="snowflake_dag",
    schedule="0 0 * * *",
    start_date=pendulum.datetime(2021, 1, 1, tz="UTC"),
    catchup=False,
    dagrun_timeout=datetime.timedelta(minutes=60),
    tags=["example", "example2"],
    params={"example_key": "example_value"},
) as dag:
    
    query1_exec = SnowflakeOperator(
        task_id="snowfalke_task1",
        sql="job01.sql",
        snowflake_conn_id="snowflake_conn"
    )

    query2_exec = SnowflakeOperator(
        task_id="snowfalke_task2",
        sql="job02.sql",
        snowflake_conn_id="snowflake_conn"
    )

    Extraer_data_1 = EmptyOperator(
        task_id="Extraer_data_1"
    )

    Extraer_data_2 = EmptyOperator(
        task_id="Extraer_data_2"
    )
    
    [Extraer_data_1, Extraer_data_2] >> query1_exec >> query2_exec
