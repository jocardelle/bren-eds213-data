-- Find the name of the observer who observed 36 float eggs between 1998 and 2008
SELECT Name, COUNT(*) AS Num_floated_nests FROM Bird_nests JOIN Personnel
ON Bird_nests.Observer = Personnel.Abbreviation
    WHERE ageMethod = 'float'
    AND Site = 'nome'
    AND Year >= 1998
    AND Year <= 2008
    GROUP BY Name
    HAVING Count(*) = 36;