# bmstu-db


## Запуск контейнера

Поднимаем контейнер: 

```bash
docker-compose --env-file config/database.env up -d
```

Коннектимся к контейнеру: 

```
docker exec -it oracle-container /bin/bash
```

## Настройка контейнера

### Предварительные настройки всяких конфигов

По-хорошему нужно было создать Dockerfile и запихнуть все это туда, но мне было лень :)

```bash
su - oracle # Обязательно работать из под юзера oracle. См. ниже, если не получается залогиниться
/scripts/exports.sh
cp /config/initdefects.ora $ORACLE_HOME/dbs 
mkdir -p /u01/app/oracle/oradata/defects && mkdir -p /u01/app/oracle/fast_recovery_area && mkdir -p /u01/app/oracle/admin/defects/adump
```

### Создание и настройка БД

```sql
sqlplus / as sysdba; # Это ещё в баше
shutdown; # Можно пропустить при создании впервые
create spfile from pfile;
startup nomount;

start /scripts/create_db.sql;
@?/rdbms/admin/catalog.sql;
@?/rdbms/admin/catproc.sql; # Тут придется подождать минут 30
@?/javavm/install/initjvm.sql;

shutdown immediate;
startup;
```

База данных готова к работе, Вы — великолепны!

### Создание юзера и таблиц

```sql
alter session set "_ORACLE_SCRIPT"=true;
start /labs/lab_03/create_user.sql; # Юзер alexey/admin
conn alexey/admin;

start /labs/lab_01/init.sql;
start /labs/lab_01/add.sql;
```

### Загрузка данных

```bash
cd /home/oracle
cp /labs/lab_01/load_cwe.ctl .
cp /labs/lab_01/load_analyzers.ctl .
cp /labs/lab_01/load_errors.ctl .

sqlldr \'alexey/admin as sysdba\' control='/home/oracle/load_cwe.ctl' log='log.ctl'
sqlldr \'alexey/admin as sysdba\' control='/home/oracle/load_analyzers.ctl' log='log.ctl'
sqlldr \'alexey/admin as sysdba\' control='/home/oracle/load_errors.ctl' log='log.ctl'
```

## Решение проблем со авторизацией в юзера oracle

Скорее всего при первом запуске контейнера что-то пойдет не так, и вы не сможете подключится в пользователя oracle. 

```bash
vi etc/pam.d/su
```

Нужно задокументировать вот эту строчку:

```
session include system-auth
```

После этого все должно заработать, пробуйте ```su - oracle```.

### Все равно не заработало

```
vi /etc/security/limits.conf
```

```
oracle           -       nofile          10
root             -       nofile          10 
```

Заменить числа справа на большие, например 100.