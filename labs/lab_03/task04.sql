DROP TYPE tree_table;
DROP TYPE tree_row;

CREATE OR REPLACE TYPE tree_row IS OBJECT (
    id INTEGER,
    parent_id INTEGER,
    description VARCHAR2(512),
    analyzer_name VARCHAR2(64)
);
/

CREATE OR REPLACE TYPE tree_table IS TABLE OF tree_row;
/

CREATE OR REPLACE FUNCTION AnalyzerTree (in_id IN integer)
RETURN tree_table IS t_table tree_table;
BEGIN
    WITH ErrorsTree(id, parent_id, description, analyzer_name)
    AS (
        SELECT id, parent_id, description, analyzer_name
        FROM errors
        WHERE id = in_id
        UNION ALL
        SELECT e.id, e.parent_id, e.description, e.analyzer_name
        FROM errors e
        JOIN ErrorsTree et
        ON e.parent_id = et.id
    )

    SELECT tree_row(ErrorsTree.id, ErrorsTree.parent_id, ErrorsTree.description, ErrorsTree.analyzer_name) 
    BULK COLLECT INTO t_table
    FROM ErrorsTree;

    RETURN t_table;
END;
/