-- 4 вариант

DROP TABLE staff_audit;
DROP TABLE staff;

CREATE TABLE staff_audit (
    id INTEGER PRIMARY KEY,
    id_employee INTEGER NOT NULL,
    day_date DATE,
    day_of_week VARCHAR2(32),
    time_w DATE,
    audit_type INTEGER
);

CREATE TABLE staff (
    id INTEGER PRIMARY KEY, --KEY REFERENCES staff_audit(id_employee),
    employee_name VARCHAR2(128),
    birthday DATE,
    department VARCHAR2(128)
);

DROP TYPE NotArWorkTable;
DROP TYPE NotAtWorkType;

CREATE OR REPLACE TYPE NotAtWorkType IS OBJECT (
    employee_name VARCHAR2(128),
    department VARCHAR2(128)
);
/

CREATE OR REPLACE TYPE NotArWorkTable IS TABLE OF NotAtWorkType;
/

CREATE OR REPLACE FUNCTION NotAtWorkToday(today DATE)
RETURN NotArWorkTable AS emp_table NotArWorkTable;
BEGIN 
    SELECT NotAtWorkType(employee_name, department)
    BULK COLLECT INTO emp_table
    FROM staff
    WHERE id NOT IN (
        SELECT id
        FROM staff_audit
        WHERE day_date = today AND audit_type = 1
    );
RETURN emp_table;
END;
/