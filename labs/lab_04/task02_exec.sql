start /labs/lab_04/task02.sql;

VARIABLE clang_tidy_total NUMBER;
CALL FormattedSumErrorCLR('clang-tidy') INTO :clang_tidy_total;
PRINT clang_tidy_total;