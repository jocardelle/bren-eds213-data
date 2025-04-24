-- Continuing with SQL
-- Somewhat arbitrary but illustrative query
SELECT Species, COUNT(*) AS Nest_count FROM Bird_nests
    WHERE Site = 'nome'
    GROUP BY Species
    HAVING Nest_count > 10
    ORDER BY Species
    LIMIT 2;

-- We can nest queries!
SELECT Scientific_name, Nest_count FROM
    (SELECT Species, COUNT(*) AS Nest_count FROM Bird_nests
        WHERE Site = 'nome'
        GROUP BY Species
        HAVING Nest_count > 10
        ORDER BY Species
        LIMIT 2) JOIN Species
    ON Species = Code;

-- Outer joins
CREATE TEMP TABLE a (
        cola INTEGER,
        common INTEGER
);
INSERT INTO a VALUES (1, 1), (2, 2), (3, 3);
SELECT * FROM a;
CREATE TEMP TABLE b (
    common INTEGER,
    colb INTEGER
);
INSERT INTO b VALUES (2, 2), (3, 3), (4, 4), (5, 5);
SELECT * FROM b;

-- The joins we've been doing so far have been "inner" joins
SELECT * FROM a JOIN b USING (common);
SELECT * FROM a JOIN b ON a.common = b.common;

-- By doing an "outer" join --- either "left" or "right" --- we'll add certain missing rows
SELECT * FROM a LEFT JOIN b ON a.common = b.common;
SELECT * FROM a RIGHT JOIN b ON a.common = b.common;

-- A running example: What species do *not* have any nest data?
SELECT COUNT(*) FROM Species;
SELECT COUNT(DISTINCT Species) FROM Bird_nests;
-- method 1
SELECT Code FROM Species
    WHERE Code NOT IN (SELECT Species FROM Bird_nests);

-- method 2
SELECT Code, Species FROM Species LEFT JOIN Bird_nests
    ON Code = Species
    WHERE Species IS NULL;

-- It's also possible to join a table with itself, a so-called "self-join"

-- Understanding a limitation of DuckDB
SELECT Nest_ID, COUNT(*) AS Num_eggs
    FROM Bird_nests JOIN Bird_eggs
    USING (Nest_ID)
    WHERE Nest_ID LIKE '13B%'
    GROUP BY Nest_ID;

-- Let's add in Observer
SELECT Nest_ID, Observer, COUNT(*) AS Num_eggs
    FROM Bird_nests JOIN Bird_eggs
    USING (Nest_ID)
    WHERE Nest_ID LIKE '13B%'
    GROUP BY Nest_ID;

SELECT * FROM Bird_nests JOIN Bird_eggs
    USING (Nest_ID)
    WHERE Nest_ID LIKE '13B%';


-- DuckDB solution #1:
SELECT Nest_ID, Observer, COUNT(*) AS Num_eggs
    FROM Bird_nests JOIN Bird_eggs
    USING (Nest_ID)
    WHERE Nest_ID LIKE '13B%'
    GROUP BY Nest_ID, Observer;

-- DuckDB solution #2:
SELECT Nest_ID, ANY_VALUE(Observer), COUNT(*) AS Num_eggs
    FROM Bird_nests JOIN Bird_eggs
    USING (Nest_ID)
    WHERE Nest_ID LIKE '13B%'
    GROUP BY Nest_ID;

-- Views: a virtual table
CREATE VIEW my_nests_2 AS 
    SELECT Nest_ID, ANY_VALUE(Observer) AS Observer, COUNT(*) AS Num_eggs
    FROM Bird_nests JOIN Bird_eggs
    USING (Nest_ID)
    WHERE Nest_ID LIKE '13B%'
    GROUP BY Nest_ID;

.tables
SELECT * FROM my_nests_2;
SELECT Nest_ID, Name, Num_eggs
    FROM my_nests_2 JOIN Personnel
    ON Observer = Abbreviation;


-- What about modifications (inserts, updates, deletes) on a view? Possible?
-- It depends
-- Whether it's theoretically possible
-- How smart the database is

-- Last topic: set operations
-- UNION, UNION ALL, INTERSECT, EXCEPT

SELECT * FROM Bird_eggs LIMIT 5;

SELECT Book_page, Year, Site, Nest_ID, Egg_num, Length*25.4 AS Length, Width*25.4 AS Width
    FROM Bird_eggs
    WHERE Book_page LIKE 'b14%'
UNION
SELECT Book_page, Year, Site, Nest_ID, Egg_num, Length, Width
    FROM Bird_eggs
    WHERE Book_page LIKE 'b14%';

-- Method 3 for running example
SELECT Code FROM Species
EXCEPT
SELECT DISTINCT Species FROM Bird_nests;