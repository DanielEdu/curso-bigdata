-- https://quickstarts.snowflake.com/guide/getting_started_with_snowpipe/index.html?index=..%2F..index#4
-- https://docs.snowflake.com/en/user-guide/data-load-s3-config-storage-integration

CREATE OR REPLACE STORAGE INTEGRATION datalake_peru_dev
  TYPE = EXTERNAL_STAGE
  STORAGE_PROVIDER = S3
  ENABLED = TRUE
  STORAGE_AWS_ROLE_ARN = 'arn:aws:iam::xxxxxxxxx:role/snowflake_role'
  STORAGE_ALLOWED_LOCATIONS = ('s3://datalake-peru/')
;

desc integration datalake_peru_dev;

-------------------------------
CREATE OR REPLACE TABLE datalake_dev.landing.json_table(jsontext variant);

desc table datalake_dev.landing.json_table;
truncate table datalake_dev.landing.json_table;
select * from datalake_dev.landing.json_table;
------------------------------------------------

use schema datalake_dev.public;


CREATE OR REPLACE STAGE datalake_dev.public.s3_stage_json
  url = ('s3://xxxxxx/landing/json/')
  storage_integration = datalake_peru_dev;

SHOW STAGES;

  
---   SNOWPIPE   ----
-- https://docs.snowflake.com/en/user-guide/data-load-snowpipe-intro

CREATE OR REPLACE TABLE datalake_dev.landing.json_table(jsontext variant);

----------------------------

CREATE OR REPLACE PIPE datalake_dev.public.s3_pipe_json auto_ingest=true as
  copy into datalake_dev.landing.json_table
  from @datalake_dev.public.s3_stage_json
  file_format = (type = 'JSON');


show pipes;
  
---- Monitorear Snowpipe ----
select
 v:executionState::varchar                  as executionState
,v:pendingFileCount::number                 as pendingFileCount
,v:numOutstandingMessagesOnChannel::number  as numOutstandingMessagesOnChannel
,v:lastReceivedMessageTimestamp::timestamp  as lastReceivedMessageTimestamp
,v:lastPulledFromChannelTimestamp::timestamp as lastPulledFromChannelTimestamp
from 
(SELECT parse_json(SYSTEM$PIPE_STATUS('datalake_dev.public.s3_pipe_json')) as v ) t
;

select * 
from table(
information_schema.copy_history(
    table_name=>'datalake_dev.public.json_table',start_time=>dateadd(hours,-1,current_timestamp())
));


----- Aplanando data (json)

select 
jsontext:iss_position,
jsontext:message::varchar,
jsontext:timestamp
from datalake_dev.landing.json_table A;

select count(1)
from datalake_dev.landing.json_table 

