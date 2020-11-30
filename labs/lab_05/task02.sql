DROP TABLE copy_cwe;

CREATE TABLE copy_cwe(
    cwe_id INTEGER PRIMARY KEY,
    name VARCHAR(256) NOT NULL,
    weakness_abstraction VARCHAR(128) NOT NULL,
    status VARCHAR(64) NOT NULL,
    description VARCHAR(512) NOT NULL,
    CHECK (cwe_id > 0),
    CHECK (weakness_abstraction IN('Base', 'Class', 'Variant', 'Pillar', 'Compound')),
    CHECK (status IN('Incomplete', 'Draft', 'Stable'))
);

CREATE OR REPLACE DIRECTORY MYDIR AS '/var/lib/oracle';
/

GRANT READ ON DIRECTORY MYDIR TO SYS;
/

DECLARE
    l_json PLJSON;
    f utl_file.file_type;
    s VARCHAR2(1024);
BEGIN
    f := utl_file.fopen('MYDIR', 'cwe.json', 'r');
    LOOP
        BEGIN
        utl_file.get_line(f, s);
        IF S IS NOT NULL THEN
            l_json := pljson(s);
            INSERT INTO copy_cwe VALUES (
                pljson_ext.get_number(l_json, 'cwe_id'), 
                l_json.get_string('name'), 
                l_json.get_string('weakness_abstraction'), 
                l_json.get_string('status'), 
                l_json.get_string('description')
            );
        END IF;
        EXCEPTION
            WHEN No_Data_Found THEN EXIT; 
        END;
    END LOOP;

    utl_file.fclose(f);
END;
/

