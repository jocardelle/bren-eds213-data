-- Who worked with whom?
-- Step 1:
SELECT * FROM Camp_assignment A JOIN Camp_assignment B
ON A.Site = B.Site;

-- Step 2:
SELECT * FROM Camp_assignment A JOIN Camp_assignment B
ON A.Site = B.Site
AND GREATEST(A.Start, B.Start) <= LEAST(A.End, B.End)
  AND A.Start IS NOT NULL
  AND B.Start IS NOT NULL
  AND A.END IS NOT NULL
  AND B.END IS NOT NULL;

-- Step 3:
SELECT A.Site, A.Observer AS Observer_1, B.Observer AS Observer_2 FROM Camp_assignment A JOIN Camp_assignment B
ON A.Site = B.Site
AND GREATEST(A.Start, B.Start) <= LEAST(A.End, B.End)
  AND A.Start IS NOT NULL
  AND B.Start IS NOT NULL
  AND A.END IS NOT NULL
  AND B.END IS NOT NULL
  WHERE A.Site = 'lkri'
  AND A.Observer < B.Observer;

-- Bonus Problem:
SELECT A.Site, p1.Name AS Name_1, p2.Name AS Name_2 FROM Camp_assignment A JOIN Camp_assignment B
ON A.Site = B.Site 
JOIN Personnel p1
ON A.Observer = p1.Abbreviation
JOIN Personnel p2
ON B.Observer = p2.Abbreviation
AND GREATEST(A.Start, B.Start) <= LEAST(A.End, B.End)
  AND A.Start IS NOT NULL
  AND B.Start IS NOT NULL
  AND A.END IS NOT NULL
  AND B.END IS NOT NULL
  WHERE A.Site = 'lkri'
  AND A.Observer < B.Observer
  ORDER BY Name_2;