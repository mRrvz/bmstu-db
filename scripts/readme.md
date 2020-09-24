export
cp /scripts/initdefects.ora $ORACLE_HOME/dbs 
mkdir -p /u01/app/oracle/oradata/defects && mkdir -p /u01/app/oracle/fast_recovery_area && mkdir -p /u01/app/oracle/admin/defects/adump

sqlplus / as sysdba;
create spfile from pfile;
start /scripts/create_db.sql
@?/rdbms/admin/catalog.sql
@?/rdbms/admin/catproc.sql

start /labs/lab_01/init.sql
start /labs/lab_01/add.sql

cd /home/oracle
cp /labs/lab_01/load_cwe.ctl .
cp /labs/lab_01/load_analyzers.ctl .
cp /labs/lab_01/load_errors.ctl .

sqlldr \'sys/061100 as sysdba\'  control='/home/oracle/load_cwe.ctl' log='log.ctl'
sqlldr \'sys/061100 as sysdba\'  control='/home/oracle/load_analyzers.ctl' log='log.ctl'
sqlldr \'sys/061100 as sysdba\'  control='/home/oracle/load_errors.ctl' log='log.ctl'

