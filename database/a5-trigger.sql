-- make a trigger in sqlite3
SELECT * FROM Bird_eggs WHERE Nest_ID = '14eabaage01';

-- Part 1: Make a trigger for Egg_num
CREATE TRIGGER egg_filler
    AFTER INSERT ON Bird_eggs
    FOR EACH ROW
    BEGIN
        UPDATE Bird_eggs
        SET Egg_num = (SELECT IFNULL(MAX(egg_num), 0) + 1
            FROM Bird_eggs
            WHERE nest_id = NEW.Nest_id
                AND Egg_num IS NOT NULL)
        WHERE rowid = NEW.rowid
        ;
    END;

-- Part 2: Update Book_page, Year, and Site from Bird_nests
DROP TRIGGER egg_filler;

CREATE TRIGGER egg_filler
AFTER INSERT ON Bird_eggs
FOR EACH ROW
BEGIN
    UPDATE Bird_eggs
    SET
        Egg_num = (SELECT IFNULL(MAX(Egg_num), 0) + 1
            FROM Bird_eggs
            WHERE Nest_ID = NEW.Nest_ID
              AND Egg_num IS NOT NULL),
        Book_page = (SELECT Book_page
            FROM Bird_nests
            WHERE Nest_ID = NEW.Nest_ID),
        Year = (SELECT Year
            FROM Bird_nests
            WHERE Nest_ID = NEW.Nest_ID),
        Site = (SELECT Site
            FROM Bird_nests
            WHERE Nest_ID = NEW.Nest_ID)
    WHERE rowid = NEW.rowid;
END;