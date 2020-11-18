CREATE OR REPLACE PROCEDURE AnalyzersNames
IS
    cur_name VARCHAR2(64);
    CURSOR analyzers_cursor IS SELECT * FROM analyzers;
BEGIN
    DBMS_OUTPUT.enable;
    FOR analyzer in analyzers_cursor
    LOOP
        cur_name := analyzer.name;
        DBMS_OUTPUT.put_line(cur_name);
    END LOOP;
END;
/