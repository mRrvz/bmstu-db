SELECT name, price, AnalyzersID.id
FROM analyzers
JOIN (
    SELECT analyzer_name, id
    FROM errors
    JOIN (
        SELECT cwe_id
        FROM cwe
        WHERE status IN (
            SELECT status
            FROM cwe
            WHERE weakness_abstraction = 'Base'
        )
    ) StatusID ON StatusID.cwe_id = errors.cwe_id
) AnalyzersID ON AnalyzersID.analyzer_name = analyzers.name;
