
-- Listing 7-1: Creating the departments and employees tables

CREATE TABLE departments (
    dept_id integer,
    dept text,
    city text,
    CONSTRAINT dept_key PRIMARY KEY (dept_id),
    CONSTRAINT dept_city_unique UNIQUE (dept, city)
);

CREATE TABLE employees (
    emp_id integer,
    first_name text,
    last_name text,
    salary numeric(10,2),
    dept_id integer REFERENCES departments (dept_id),
    CONSTRAINT emp_key PRIMARY KEY (emp_id)
);

INSERT INTO departments
VALUES
    (1, 'Tax', 'Atlanta'),
    (2, 'IT', 'Boston');

INSERT INTO employees
VALUES
    (1, 'Julia', 'Reyes', 115300, 1),
    (2, 'Janet', 'King', 98000, 1),
    (3, 'Arthur', 'Pappas', 72700, 2),
    (4, 'Michael', 'Taylor', 89500, 2);

-- Listing 7-2: Joining the employees and departments tables

SELECT *
FROM employees JOIN departments
ON employees.dept_id = departments.dept_id
ORDER BY employees.dept_id;

----------------------------------------


-- Listing 7-3: Creating two tables to explore JOIN types

CREATE TABLE district_2020 (
    id integer CONSTRAINT id_key_2020 PRIMARY KEY,
    school_2020 text
);

CREATE TABLE district_2035 (
    id integer CONSTRAINT id_key_2035 PRIMARY KEY,
    school_2035 text
);

INSERT INTO district_2020 VALUES
    (1, 'Oak Street School'),
    (2, 'Roosevelt High School'),
    (5, 'Dover Middle School'),
    (6, 'Webutuck High School');

INSERT INTO district_2035 VALUES
    (1, 'Oak Street School'),
    (2, 'Roosevelt High School'),
    (3, 'Morrison Elementary'),
    (4, 'Chase Magnet Academy'),
    (6, 'Webutuck High School');

-- Listing 7-4: Using JOIN

SELECT *
FROM district_2020 JOIN district_2035
ON district_2020.id = district_2035.id
ORDER BY district_2020.id;



-- Listing 7-5: JOIN with USING
-- If you’re using identical names for columns in a join’s ON clause, 
--  you can reduce redundant output and simplify the query syntax 
SELECT *
FROM district_2020 JOIN district_2035
USING (id)
ORDER BY district_2020.id;


-- Listing 7-6: Using LEFT JOIN

SELECT *
FROM district_2020 LEFT JOIN district_2035
ON district_2020.id = district_2035.id
ORDER BY district_2020.id;

-- Listing 7-7: Using RIGHT JOIN

SELECT *
FROM district_2020 RIGHT JOIN district_2035
ON district_2020.id = district_2035.id
ORDER BY district_2035.id;

-- Listing 7-8: Using FULL OUTER JOIN

SELECT *
FROM district_2020 FULL OUTER JOIN district_2035
ON district_2020.id = district_2035.id
ORDER BY district_2020.id;

-- Listing 7-9: Using CROSS JOIN

SELECT *
FROM district_2020 CROSS JOIN district_2035
ORDER BY district_2020.id, district_2035.id;


-- Alternately, a CROSS JOIN can be written with a comma-join syntax:
SELECT *
FROM district_2020, district_2035
ORDER BY district_2020.id, district_2035.id;

-- Or it can be written as a JOIN with true in the ON clause:
SELECT *
FROM district_2020 JOIN district_2035 ON true
ORDER BY district_2020.id, district_2035.id;

-- Listing 7-10: Filtering to show missing values with IS NULL

SELECT *
FROM district_2020 LEFT JOIN district_2035
ON district_2020.id = district_2035.id
WHERE district_2035.id IS NULL;

-- alternately, with a RIGHT JOIN
SELECT *
FROM district_2020 RIGHT JOIN district_2035
ON district_2020.id = district_2035.id
WHERE district_2020.id IS NULL;

-- Listing 7-11: Querying specific columns in a join

SELECT district_2020.id,
       district_2020.school_2020,
       district_2035.school_2035
FROM district_2020 LEFT JOIN district_2035
ON district_2020.id = district_2035.id
ORDER BY district_2020.id;



-- Listing 7-14: Combining query results with UNION

SELECT * FROM district_2020
UNION
SELECT * FROM district_2035
ORDER BY id;

-- Listing 7-15: Combining query results with UNION ALL

SELECT * FROM district_2020
UNION ALL
SELECT * FROM district_2035
ORDER BY id;


-- Listing 7-17: Combining query results with INTERSECT and EXCEPT

SELECT * FROM district_2020
INTERSECT
SELECT * FROM district_2035
ORDER BY id;

SELECT * FROM district_2020
EXCEPT
SELECT * FROM district_2035
ORDER BY id;