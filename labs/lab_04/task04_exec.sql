start /labs/lab_04/task04.sql;

SELECT SUM(price) FROM errors WHERE analyzer_name = 'clang-tidy';

BEGIN
    UpdatePriceCLR('clang-tidy', 1500);
END;
/

SELECT SUM(price) FROM errors WHERE analyzer_name = 'clang-tidy';