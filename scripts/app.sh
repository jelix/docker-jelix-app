#!/bin/bash

updateApp() {
    
    # Launch or update the Jelix application
    #/usr/bin/mysqld_safe > /dev/null 2>&1 &
    /usr/bin/mysqld_safe 2>&1 &
    
    RET=1
    while [[ RET -ne 0 ]]; do
        echo "Waiting for confirmation of MySQL service startup"
        sleep 1
        mysql -uroot -e "status"  2>&1
        RET=$?
    done
    
    
    if [ -f "/var/www/$JELIX_APP_DIR_NAME/install/installer.php" ]; then
        echo "Launch Jelix App installer/updater"
        cd /var/www/$JELIX_APP_DIR_NAME/install/
        php installer.php
    fi
    
    mysqladmin -uroot shutdown
}

#updateApp  # there are still issue
exec supervisord -n


