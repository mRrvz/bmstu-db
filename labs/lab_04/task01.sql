CREATE OR REPLACE FUNCTION SumErrorsCLR(analyzer_name IN VARCHAR2) 
RETURN NUMBER AS
LANGUAGE JAVA 
NAME 'CLRManager.SumErrors(java.lang.String) return int';
/