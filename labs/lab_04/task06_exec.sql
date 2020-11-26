
DECLARE    
    obj MinAnalyzerInfo_;
BEGIN
    obj := AnalyzerMinInfoCLR('clang-tidy');
    INSERT INTO analyzers_min_info VALUES (obj);
END;
/

SELECT * FROM analyzers_min_info;