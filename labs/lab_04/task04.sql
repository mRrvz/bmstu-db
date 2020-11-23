CREATE OR REPLACE PROCEDURE UpdatePriceCLR(analyzer_name IN VARCHAR2, increase_price NUMBER) 
AS LANGUAGE JAVA 
NAME 'CLRManager.UpdatePrice(java.lang.String, int)';
/