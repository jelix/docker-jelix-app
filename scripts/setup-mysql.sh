#!/bin/bash
set -e
echo "========= mysql setup"
chown -R mysql:mysql /var/lib/mysql
mysql_install_db --user mysql > /dev/null

MYSQL_ROOT_PASSWORD=${MYSQL_ROOT_PASSWORD:-"root"}

sql=`mktemp`
if [[ ! -f "$sql" ]]; then
return 1
fi

cat << EOF > $sql
USE mysql;
FLUSH PRIVILEGES;
GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' WITH GRANT OPTION;
UPDATE user SET password=PASSWORD("$MYSQL_ROOT_PASSWORD") WHERE user='root';
EOF

/usr/sbin/mysqld --bootstrap --verbose=0 < $sql
rm -f $sql

echo "========= end of mysql setup"
