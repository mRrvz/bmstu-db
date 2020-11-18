CREATE OR REPLACE TRIGGER ShutdownTrigger
BEFORE SHUTDOWN ON DATABASE
BEGIN
    INSERT INTO shutdown_audit VALUES (
        SYSDATE,
        TO_CHAR(sysdate, 'HH24:MM:SS')
    );
END;
/

CREATE OR REPLACE TRIGGER StartUpTrigger
AFTER STARTUP ON DATABASE
BEGIN
    INSERT INTO startup_audit VALUES (
        SYSDATE,
        TO_CHAR(sysdate, 'HH24:MM:SS')
    );
END;
/

