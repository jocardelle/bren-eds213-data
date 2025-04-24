-- List scientific names of bird species and their max average egg volumes

-- Create average volumes by nest
CREATE TEMP TABLE Averages AS
    SELECT Nest_ID, AVG(3.14/6 * Width * Width * Length) AS Avg_volume
        FROM Bird_eggs
        GROUP BY Nest_ID;
SELECT * FROM Bird_nests;

-- Join with Bird_nests
CREATE TEMP TABLE Max_volume AS
SELECT Species, MAX(Avg_volume)
    FROM Bird_nests JOIN Averages USING (Nest_ID)
    GROUP BY Species;

-- Join with Species to get scientific name
SELECT Scientific_name, "max(Avg_volume)" as Max_avg_volume
    FROM Species JOIN Max_volume ON Code = Species
    GROUP BY Scientific_name, "max(Avg_Volume)"
    ORDER BY Max_avg_volume DESC;