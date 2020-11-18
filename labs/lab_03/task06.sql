DROP TYPE acc_table;
DROP TYPE acc_row;

CREATE OR REPLACE TYPE acc_row IS OBJECT (
    id INTEGER
);
/

CREATE OR REPLACE TYPE acc_table IS TABLE OF acc_row;
/

CREATE OR REPLACE PROCEDURE UpdatePriceTree (in_id IN integer, increase_price IN INTEGER) IS
    t_acc acc_table := acc_table();
BEGIN
    WITH ErrorsTree(id, parent_id)
    AS (
        SELECT id, parent_id
        FROM errors
        WHERE id = in_id
        UNION ALL
        SELECT e.id, e.parent_id
        FROM errors e
        JOIN ErrorsTree et
        ON e.parent_id = et.id
    )

    SELECT acc_row(id)
    BULK COLLECT INTO t_acc
    FROM ErrorsTree;

    UPDATE errors SET price = price + increase_price
    WHERE errors.id IN (SELECT id FROM TABLE(t_acc));
END;
/