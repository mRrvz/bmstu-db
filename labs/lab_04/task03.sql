DROP TYPE errors_table;
DROP TYPE errors_row;

CREATE OR REPLACE TYPE errors_row AS OBJECT (
    danger_level VARCHAR2(128),
    price VARCHAR2(128), 
    flex_coeff VARCHAR2(128)
);
/

CREATE OR REPLACE TYPE errors_table AS TABLE OF errors_row;
/

CREATE OR REPLACE FUNCTION ErrorsTableCoeffCLR (analyzer_name IN VARCHAR2)
RETURN errors_table
AS LANGUAGE JAVA
NAME 'CLRManager.AnalyzerErrorsInfo(java.lang.String) return oracle.sql.ARRAY.ARRAY';
/