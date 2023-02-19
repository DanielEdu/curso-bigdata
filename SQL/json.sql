-- Listing 16-2: Creating a table to hold JSON data and adding an index

CREATE TABLE films (
    id integer GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    film jsonb NOT NULL
);

COPY films (film)
FROM '/tmp/data/films.json';

CREATE INDEX idx_film ON films USING GIN (film);

SELECT * FROM films;

------------------

-- Listing 16-3: Retrieving a JSON key value with field extraction operators 

-- Returns the key value as a JSON data type
SELECT id, film -> 'title' AS title
FROM films
ORDER BY id;

-- Returns the key value as text
SELECT id, film ->> 'title' AS title
FROM films
ORDER BY id;

-- Returns the entire array as a JSON data type
SELECT id, film -> 'genre' AS genre
FROM films
ORDER BY id;


CREATE  TABLE IF NOT EXISTS films_clean as
    SELECT
        id,
        film ->> 'title'         AS title,
        film ->> 'year'         AS year,
        film -> 'rating'        AS rating,
        film -> 'characters'    AS characters,
        film -> 'genre'         as genre
    FROM films
;