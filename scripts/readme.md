export
cp /scripts/initdefects $ORACLE_HOME/dbs
mkdir -p /u01/app/oracle/oradata/defects
mkdir -p /u01/app/oracle/fast_recovery_area
mkdir -p /u01/app/oracle/admin/defects/adump

sqlplus / as sysdba;
create spfile from pfile;
start /scripts/create_db.sql
@?/rdbms/admin/catalog.sql
@?/rdbms/admin/catproc.sql


