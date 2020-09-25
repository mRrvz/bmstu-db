CREATE GLOBAL TEMPORARY TABLE AnalyzerErrorsStat (
    name VARCHAR(50) NOT NULL,
    analyzer_price INTEGER,
    error_id INTEGER,
    error_price INTEGER
) ON COMMIT DELETE ROWS;

INSERT INTO AnalyzerErrorsStat (
SELECT analyzers.name,
       analyzers.price,
       errors.id,
       errors.price
FROM errors JOIN analyzers ON errors.analyzer_name = analyzers.name);
