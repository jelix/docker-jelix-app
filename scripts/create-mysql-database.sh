#!/bin/bash
MYSQL_DATABASE=${MYSQL_DATABASE:-"$1"}
MYSQL_USER=${MYSQL_USER:-"$2"}
MYSQL_PASSWORD=${MYSQL_PASSWORD:-"$3"}

if [[ "$MYSQL_DATABASE" != "" ]]; then
echo "---------------- start create database"
    sql=`mktemp`
    if [[ ! -f "$sql" ]]; then
        return 1
    fi

    cat << EOF > $sql
    FLUSH PRIVILEGES;
    CREATE DATABASE IF NOT EXISTS $MYSQL_DATABASE CHARACTER SET utf8 COLLATE utf8_general_ci;
    GRANT ALL ON $MYSQL_DATABASE.* to '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD';
EOF
   
    /usr/sbin/mysqld --bootstrap  < $sql
cat $sql
    rm -f $sql
    ls -al /var/lib/mysql
echo "------------------- end create database"
fi
