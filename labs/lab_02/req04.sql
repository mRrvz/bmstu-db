SELECT cwe_id, name
FROM cwe
WHERE weakness_abstraction IN (
    SELECT weakness_abstraction
    FROM cwe
    WHERE description LIKE '%memory%'
);
