SELECT cwe_id, name,
    CASE status
        WHEN 'Incomplete' THEN 'This is new error.'
        WHEN 'Draft' THEN 'This is future error.'
        ELSE 'This is old error.'
    END
FROM cwe;
