
--CREATE OR REPLACE TYPE MinAnalyzerInfo_ AS OBJECT (
    --analyzer_name VARCHAR2(128),
    --price VARCHAR(128),
    --sum_errors_price VARCHAR2(128)
--);
--/

--create table  analyzers_min_info of minanalyzerinfo_;
--/

CREATE OR REPLACE FUNCTION AnalyzerMinInfoCLR(analyzer_name IN VARCHAR2)
RETURN MinAnalyzerInfo_
AS LANGUAGE JAVA
NAME 'CLRManager.MinAnalyzerInfo(java.lang.String) return oracle.sql.STRUCT';
/