.table

-- there are a lot of "dot-commands" in DuckDB
.help
.help show
.show
-- .exit will exit DuckDB, or Ctrl-D

-- Start with SQL
SELECT * FROM Site;
-- SQL is case-insensitive, but uppercase is the tradition
select * from site;

-- A multi-line statement
SELECT *
    FROM Site;

-- SELECT *; all rows, all columns

-- LIMIT clause
SELECT *
    FROM Site
    LIMIT 3;

SELECT * FROM Site
    LIMIT 3
    OFFSET 3;

-- selecting distinct items
SELECT * FROM Bird_nests LIMIT 1;
SELECT Species FROM Bird_nests;
SELECT DISTINCT Species FROM Bird_nests;
SELECT DISTINCT Species, Observer FROM Bird_nests;

-- add ordering
SELECT DISTINCT Species, Observer
    FROM Bird_nests
    ORDER BY Species, Observer DESC;

-- Look at Site table
SELECT * FROM Site;

-- Select distinct locations from the site table
SELECT DISTINCT Location FROM Site;

-- Are they returned in order? If not, order them
SELECT DISTINCT Location FROM Site ORDER BY Location;

-- Add a LIMIT clause to return just 3 results
SELECT DISTINCT Location FROM Site 
    ORDER BY Location 
    LIMIT 3;