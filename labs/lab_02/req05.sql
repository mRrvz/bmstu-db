SELECT errors.id, errors.cwe_id, cwe.description
FROM errors 
JOIN cwe 
ON errors.cwe_id = cwe.cwe_id
WHERE EXISTS (
    SELECT *
    FROM errors
    WHERE errors.analyzer_name = 'clang-tidy'
);

