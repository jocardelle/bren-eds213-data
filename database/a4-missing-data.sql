-- Which site have no egg data?

-- Method 1: Using a Code NOT IN (subquery) clause.
SELECT  Code FROM Site
    WHERE Code NOT IN (SELECT  site FROM    bird_eggs)
    ORDER BY Code;


-- Method 2: Using an outer join with a WHERE clause
SELECT Code FROM Site LEFT JOIN bird_eggs
    ON Code = Site
    Where Site IS NULL
    ORDER BY Code;

-- Method 3: Using EXCEPT
SELECT Code FROM Site
EXCEPT
SELECT DISTINCT Site FROM Bird_eggs
ORDER BY Code;