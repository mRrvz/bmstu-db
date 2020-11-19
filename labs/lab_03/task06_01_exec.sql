SELECT ID FROM TABLE(AnalyzerTree(3));

SELECT price FROM ERRORS
WHERE id = 3 OR id = 4 OR id = 5;

BEGIN
    UpdatePriceTreeRec(3, 3, 500);
END;
/

SELECT price FROM ERRORS
WHERE id = 3 OR id = 4 OR id = 5;