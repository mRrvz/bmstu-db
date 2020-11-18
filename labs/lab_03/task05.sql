CREATE OR REPLACE PROCEDURE UpdatePrice(analyzer_name IN VARCHAR2, increase_price IN INTEGER) AS
BEGIN
    UPDATE errors SET price = price + increase_price
    WHERE errors.analyzer_name = analyzer_name;
END;
/