CREATE OR REPLACE VIEW AnalyzersAndErrors AS 
SELECT A.name, E.description, E.price
FROM analyzers A JOIN errors E on A.name = E.analyzer_name;
/

CREATE OR REPLACE TRIGGER UpdateViewTrigger
INSTEAD OF UPDATE 
ON AnalyzersAndErrors
FOR EACH ROW
BEGIN
    IF :new.price > 10000 THEN
        UPDATE AnalyzersAndErrors
        SET price = 10000
    WHERE name = :new.name;
    END IF;
END;
/