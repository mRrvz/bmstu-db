DROP TYPE errors_table;
DROP TYPE errors_row;

CREATE OR REPLACE TYPE errors_row IS OBJECT (
    description VARCHAR2(512),
    danger_level NUMBER(3),
    price INTEGER
);
/

CREATE OR REPLACE TYPE errors_table IS TABLE OF errors_row;
/

CREATE OR REPLACE FUNCTION AnalyzerErrorsInfo (analyzer_name IN VARCHAR2)
RETURN errors_table AS e_table errors_table;
BEGIN
    SELECT errors_row(description,
                      danger_level,
                      price)
    BULK COLLECT INTO e_table
    FROM errors 
    WHERE errors.analyzer_name = analyzer_name;
RETURN e_table;
END;
/