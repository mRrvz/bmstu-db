SELECT *
FROM (
    SELECT name, languages, cwe_id,
    ROW_NUMBER() OVER (PARTITION BY cwe_id ORDER BY cwe_id) as cnt
    FROM analyzers
    JOIN errors
    ON errors.analyzer_name = analyzers.name
) WHERE cnt = 1;
