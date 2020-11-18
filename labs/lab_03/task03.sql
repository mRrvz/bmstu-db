DROP TYPE eprice_table;
DROP TYPE eprice_row;

CREATE OR REPLACE TYPE eprice_row IS OBJECT (
    cwe_id INTEGER,
    description VARCHAR2(512),
    price INTEGER
);
/

CREATE OR REPLACE TYPE eprice_table IS TABLE OF eprice_row;
/

CREATE OR REPLACE FUNCTION ErrorsPriceInfo (analyzer_name IN VARCHAR2)
RETURN eprice_table AS ep_table eprice_table;
    avg_price INTEGER := 0;
    min_price INTEGER := 0;
BEGIN
    SELECT AVG(price), MIN(price)
    INTO avg_price, min_price
    FROM errors;

    SELECT eprice_row(cwe_id,
                      description, 
                      price)
    BULK COLLECT INTO ep_table
    FROM (
        SELECT cwe_id, 
               description, 
               price
        FROM errors
        WHERE errors.analyzer_name = analyzer_name
    ) WHERE price > avg_price AND price > min_price;
RETURN ep_table;
END;
/