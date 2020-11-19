DROP TYPE tree_acc_table;
DROP TYPE tree_acc_row;

CREATE OR REPLACE TYPE tree_acc_row IS OBJECT (
    id INTEGER,
    parent_id INTEGER
);
/

CREATE OR REPLACE TYPE tree_acc_table IS TABLE OF tree_acc_row;
/

CREATE OR REPLACE PROCEDURE UpdatePriceTreeRec (in_id IN INTEGER, parent_id IN INTEGER, increase_price IN INTEGER) IS
    tree_acc tree_acc_table := tree_acc_table();
BEGIN
    IF in_id = parent_id THEN
        SELECT tree_acc_row(id, parent_id)
        BULK COLLECT INTO tree_acc
        FROM (
            SELECT id, parent_id
            FROM errors
            WHERE id = in_id
         );
    ELSE
        SELECT tree_acc_row(id, parent_id)
        BULK COLLECT INTO tree_acc
        FROM (
            SELECT id, parent_id
            FROM errors
            WHERE parent_id = in_id
        );
    END IF;

    UPDATE errors SET price = price + increase_price
    WHERE errors.id IN (SELECT id FROM TABLE(tree_acc));
    
    FOR errors IN (SELECT * FROM TABLE(tree_acc))
    LOOP
        UpdatePriceTreeRec(errors.id, errors.parent_id, increase_price);
    END LOOP;
END;
/
