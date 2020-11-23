start /labs/lab_04/task01.sql;

VARIABLE clang_tidy_sum NUMBER;
CALL SumErrorsCLR('clang-tidy') INTO :clang_tidy_sum;
PRINT clang_tidy_sum;