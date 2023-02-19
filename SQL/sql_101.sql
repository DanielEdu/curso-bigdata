-- Listing 1-1: Checking your PostgreSQL version
SELECT version();


-- Crear base de datos analysis
CREATE DATABASE analysis;


-- Listing 2-2: Creating a table named teachers with six columns, Character data types in action
CREATE TABLE teachers (
    id bigserial,
    first_name varchar(25),
    last_name varchar(50),
    school varchar(50),
    hire_date date,
    salary numeric
);


-- Listing 2-3 Inserting data into the teachers table
INSERT INTO teachers (first_name, last_name, school, hire_date, salary)
VALUES ('Janet', 'Smith', 'F.D. Roosevelt HS', '2011-10-30', 36200),
       ('Lee', 'Reynolds', 'F.D. Roosevelt HS', '1993-05-22', 65000),
       ('Samuel', 'Cole', 'Myers Middle School', '2005-08-01', 43500),
       ('Samantha', 'Bush', 'Myers Middle School', '2011-10-30', 36200),
       ('Betty', 'Diaz', 'Myers Middle School', '2005-08-30', 43500),
       ('Kathleen', 'Roush', 'F.D. Roosevelt HS', '2010-10-22', 38500)
;


-- SQL sintax
-- included cast
SELECT [DISTINCT] <columns | *> [as rename_column]
       -- CAST(numeric_column AS integer),
FROM [database_name].[schema.name].<table_name>
WHERE true  
    [ AND | OR ] <column_name> 
[ORDER BY <column>]
;


--    ##### Importing and Exporting Data  #####    

-- This is example syntax only; running it will produce an error

COPY table_name
FROM '/tmp/.../your_file.csv'
WITH (FORMAT CSV, HEADER);
--  chmod 777


-- Listing 5-2: CREATE TABLE statement for Census county population estimates
-- Data dictionary for estimates available at: https://www2.census.gov/programs-surveys/popest/technical-documentation/file-layouts/2010-2019/co-est2019-alldata.pdf
-- Data dictionary for additional columns at: http://www.census.gov/prod/cen2010/doc/pl94-171.pdf
-- Note: Some columns have been given more descriptive names
CREATE TABLE us_counties_pop_est_2019 (
    state_fips text,                         -- State FIPS code
    county_fips text,                        -- County FIPS code
    region smallint,                         -- Region
    state_name text,                         -- State name	
    county_name text,                        -- County name
    area_land bigint,                        -- Area (Land) in square meters
    area_water bigint,                       -- Area (Water) in square meters
    internal_point_lat numeric(10,7),        -- Internal point (latitude)
    internal_point_lon numeric(10,7),        -- Internal point (longitude)
    pop_est_2018 integer,                    -- 2018-07-01 resident total population estimate
    pop_est_2019 integer,                    -- 2019-07-01 resident total population estimate
    births_2019 integer,                     -- Births from 2018-07-01 to 2019-06-30
    deaths_2019 integer,                     -- Deaths from 2018-07-01 to 2019-06-30
    international_migr_2019 integer,         -- Net international migration from 2018-07-01 to 2019-06-30
    domestic_migr_2019 integer,              -- Net domestic migration from 2018-07-01 to 2019-06-30
    residual_2019 integer,                   -- Residual for 2018-07-01 to 2019-06-30
    CONSTRAINT counties_2019_key PRIMARY KEY (state_fips, county_fips)	
);



-- Listing 5-4: Creating a table to track supervisor salaries

CREATE TABLE supervisor_salaries (
    id          integer GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    town        text,
    county      text,
    supervisor  text,
    start_date  timestamp,
    salary      numeric(10,2),
    benefits    numeric(10,2)
);

-- Listing 5-5: Importing salaries data from CSV to three table columns

COPY supervisor_salaries (town, supervisor, salary)
FROM 'C:\YourDirectory\supervisor_salaries.csv'
WITH (FORMAT CSV, HEADER);


-- Listing 5-6: Importing a subset of rows with WHERE
DELETE FROM supervisor_salaries;

COPY supervisor_salaries (town, supervisor, salary)
FROM 'C:\YourDirectory\supervisor_salaries.csv'
WITH (FORMAT CSV, HEADER)
WHERE town = 'New Brillig';



-- Listing 5-7: Using a temporary table to add a default value to a column during
-- import
DELETE FROM supervisor_salaries;

CREATE TEMPORARY TABLE supervisor_salaries_temp 
    (LIKE supervisor_salaries INCLUDING ALL);

COPY supervisor_salaries_temp (town, supervisor, salary)
FROM 'C:\YourDirectory\supervisor_salaries.csv'
WITH (FORMAT CSV, HEADER);

INSERT INTO supervisor_salaries (town, county, supervisor,start_date, salary)
SELECT town, 'Mills', supervisor,LOCALTIMESTAMP, salary
FROM supervisor_salaries_temp;


-- Check the data
SELECT * FROM supervisor_salaries ORDER BY id LIMIT 2;



-- Listing 5-8: Exporting an entire table with COPY

COPY us_counties_pop_est_2019
TO 'C:\YourDirectory\us_counties_export.txt'
WITH (FORMAT CSV, HEADER, DELIMITER '|');


-- Listing 5-9: Exporting selected columns from a table with COPY

COPY us_counties_pop_est_2019 
    (county_name, internal_point_lat, internal_point_lon)
TO 'C:\YourDirectory\us_counties_latlon_export.txt'
WITH (FORMAT CSV, HEADER, DELIMITER '|');

-- Listing 5-10: Exporting query results with COPY

COPY (
    SELECT county_name, state_name
    FROM us_counties_pop_est_2019
    WHERE county_name ILIKE '%mill%'
     )
TO 'C:\YourDirectory\us_counties_mill_export.csv'
WITH (FORMAT CSV, HEADER);