CREATE OR REPLACE FUNCTION FormattedSumErrorCLR(analyzer_name IN VARCHAR2) 
RETURN NUMBER AS
LANGUAGE JAVA 
NAME 'CLRManager.FormattedSumErrors(java.lang.String) return int';
/