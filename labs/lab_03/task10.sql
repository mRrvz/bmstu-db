DROP VIEW AnalyzersAndErrors;

CREATE OR REPLACE VIEW AnalyzersAndErrors AS 
SELECT name, E.id, E.description, E.price
FROM analyzers A JOIN errors E on A.name = E.analyzer_name;
/

CREATE OR REPLACE TRIGGER UpdateViewTrigger
INSTEAD OF UPDATE 
ON AnalyzersAndErrors
FOR EACH ROW
BEGIN
    IF :new.price > 10000 THEN
        UPDATE errors
        SET price = 10000
        WHERE id = :new.id;
    END IF;
END;
/
