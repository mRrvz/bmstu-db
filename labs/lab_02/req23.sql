WITH ErrorsTree (id, parent_id, description, analyzer_name)
AS (
    SELECT id, parent_id, description, analyzer_name
    FROM errors
    WHERE id = 2190
    UNION ALL
    SELECT e.id, e.parent_id, e.description, e.analyzer_name
    FROM errors e
    JOIN ErrorsTree et
    ON e.parent_id = et.id
) 
SELECT * 
FROM ErrorsTree;
