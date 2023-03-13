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