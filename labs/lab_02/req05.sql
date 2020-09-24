SELECT cwe_id, description
FROM errors
WHERE EXISTS (
    SELECT *
    FROM analyzers
    WHERE price BETWEEN 100000 AND 1000000
);

