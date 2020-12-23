-- DROP TABLE nifi_audit;

CREATE TABLE nifi_audit(
    id INTEGER GENERATED ALWAYS AS IDENTITY START WITH 1 PRIMARY KEY,
    cwe_id INTEGER NOT NULL,
    event_type VARCHAR2(16) NOT NULL,
    event_date DATE NOT NULL,
    event_time VARCHAR(15) NOT NULL,
    FOREIGN KEY(cwe_id) REFERENCES cwe(cwe_id)
);

CREATE OR REPLACE TRIGGER nifi_insert_trigger
AFTER INSERT
    ON cwe
    FOR EACH ROW

BEGIN
    INSERT INTO nifi_audit
    (cwe_id, event_type, event_date, event_time)
    VALUES
    (:new.cwe_id, 'Insert', SYSDATE, TO_CHAR(SYSDATE, 'HH24:MM:SS'));
END;
/
