CREATE OR REPLACE PROCEDURE DeleteTriggers IS
    ttype VARCHAR2(128);
    ttname VARCHAR2(128);
    count_ INTEGER;
BEGIN
    count_ := 0;
    DBMS_OUTPUT.enable(1000000);
    FOR trigger IN (
        SELECT trigger_name, trigger_type
        FROM all_triggers
    ) LOOP
        ttype := trigger.trigger_type;
        ttname := trigger.trigger_name;
        IF ttype = 'CREATE' OR ttype = 'ALTER' OR ttype = 'DROP' THEN
            EXECUTE IMMEDIATE 'DROP TRIGGER $ttname';
            count_ := count_ + 1;
        END IF;
    END LOOP;
    DBMS_OUTPUT.put_line(count_);
END;
/

BEGIN
    DeleteTriggers();
END;
/