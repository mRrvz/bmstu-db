CREATE OR REPLACE FUNCTION TotalSumCLR(analyzer_name IN VARCHAR2) 
RETURN NUMBER AS
LANGUAGE JAVA 
NAME 'CLRManager.TotalSum(java.lang.String) return int';
/