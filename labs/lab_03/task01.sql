CREATE OR REPLACE FUNCTION SumErrors (analyzer_name IN VARCHAR2) 
RETURN INTEGER
IS 
    errors_price INTEGER;
BEGIN
    SELECT SUM(price)
    INTO errors_price
    FROM errors 
    WHERE errors.analyzer_name = analyzer_name;
RETURN errors_price;
END;
/