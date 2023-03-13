from __future__ import annotations

import datetime

import pendulum

from airflow import DAG
from airflow.operators.bash import BashOperator
from airflow.operators.empty import EmptyOperator
from airflow.contrib.operators.snowflake_operator import SnowflakeOperator

query = """
CREATE OR REPLACE TABLE  DATALAKE_DEV.BRONZE.CALL_CENTER_FULL AS 
    SELECT CC_CALL_CENTER_SK, CC_REC_START_DATE ,CC_COUNTY , CC_CITY , CC_REC_END_DATE,CC_MKT_CLASS
    FROM SNOWFLAKE_SAMPLE_DATA.TPCDS_SF100TCL.CALL_CENTER
    where cc_state = 'MI'
    AND CC_REC_END_DATE is not null
    
    UNION ALL
    
    SELECT CC_CALL_CENTER_SK, CC_REC_START_DATE ,CC_COUNTY , CC_CITY , CC_REC_END_DATE,CC_MKT_CLASS
    FROM SNOWFLAKE_SAMPLE_DATA.TPCDS_SF100TCL.CALL_CENTER
    where true 
    AND cc_state = 'TN' 
    AND CC_REC_END_DATE is not null
    ;
"""


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
        sql=query,
        snowflake_conn_id="snowflake_conn"
    )

    Extraer_data_1 = EmptyOperator(
        task_id="Extraer_data_1"
    )

    Extraer_data_2 = EmptyOperator(
        task_id="Extraer_data_2"
    )
    
    [Extraer_data_1, Extraer_data_2] >> query1_exec
