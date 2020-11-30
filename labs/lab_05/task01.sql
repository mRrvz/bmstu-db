SPOOL /var/lib/oracle/cwe.json
 
SET HEADING OFF
SET FEEDBACK OFF
SET LINESIZE 1000

SELECT JSON_OBJECT('cwe_id' VALUE cwe_id, 
                   'name' VALUE name,
                   'weakness_abstraction' VALUE weakness_abstraction,
                   'status' VALUE status,
                   'description' VALUE description
) FROM cwe;

SPOOL OFF;