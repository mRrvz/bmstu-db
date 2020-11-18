CREATE OR REPLACE PROCEDURE OwnerTables (in_owner IN VARCHAR2) IS
    tname VARCHAR2(128);
BEGIN
    DBMS_OUTPUT.enable(1000000);
    FOR user_table IN (
        SELECT table_name
        FROM all_tables
        WHERE owner = in_owner
    ) LOOP 
        tname := user_table.table_name;
        DBMS_OUTPUT.put_line(tname);
    END LOOP;
END;
/