-- PART 1
-- Why is duckdby rejecting this:
SELECT Site_name, MAX(Area) FROM Site;

-- We get this error because duckdb doesn't know which Site_name to associate with MAX(Area)
-- We could include a GROUP BY to fix this

-- PART 2 - order rows
SELECT Site_name, Area FROM Site 
    ORDER BY Area DESC
    LIMIT 1;

-- PART 3 - nested query
SELECT Site_name, Area
FROM Site
WHERE Area = (SELECT MAX(Area) FROM Site);