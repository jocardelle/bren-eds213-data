-- make a trigger in sqlite3
SELECT * FROM Bird_eggs WHERE Nest_ID = '14eabaage01';

-- Part 1: Make a trigger for Egg_num
CREATE TRIGGER egg_filler
    AFTER INSERT ON Bird_eggs
    FOR EACH ROW
    BEGIN
        UPDATE Bird_eggs
        SET Egg_num = (
            SELECT IFNULL(MAX(egg_num), 0) + 1
            FROM Bird_eggs
            WHERE nest_id = NEW.nest_id)
        ;
    END;
