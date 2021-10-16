#!/bin/bash

set -x

cd /app

curl -s https://get.sdkman.io | bash
source "$HOME/.sdkman/bin/sdkman-init.sh"
sdk install grails 3.3.10
wget https://github.com/ppazos/cabolabs-ehrserver/archive/master.zip
unzip master.zip
service mysql start
SECURE_MYSQL=$(expect -c "

set timeout 10
spawn mysql_secure_installation

expect \"Enter current password for root (enter for none):\"
send \"r\"

expect \"Set root password?\"
send \"n\r\"

expect \"Switch to unix_socket authentication?\"
send \"n\r\"

expect \"Change the root password?\"
send \"n\r\"

expect \"Remove anonymous users?\"
send \"y\r\"

expect \"Disallow root login remotely?\"
send \"y\r\"

expect \"Remove test database and access to it?\"
send \"y\r\"

expect \"Reload privilege tables now?\"
send \"y\r\"

expect eof
")

echo $SECURE_MYSQL

mysql -u root -e "CREATE DATABASE ${EHRSERVER_DB_NAME};"
mysql -u root -e "CREATE USER '${EHRSERVER_MYSQL_DB_USERNAME}'@'%' IDENTIFIED BY '${EHRSERVER_MYSQL_DB_PASSWORD}';"
mysql -u root -e "CREATE USER '${EHRSERVER_MYSQL_DB_USERNAME}'@'localhost' IDENTIFIED BY '${EHRSERVER_MYSQL_DB_PASSWORD}';"
mysql -u root -e "GRANT ALL ON ${EHRSERVER_DB_NAME}.* TO '${EHRSERVER_MYSQL_DB_USERNAME}'@'%'"
mysql -u root -e "GRANT ALL ON ${EHRSERVER_DB_NAME}.* TO '${EHRSERVER_MYSQL_DB_USERNAME}'@'localhost'"
mysql -u root  -e "FLUSH PRIVILEGES"

cd ./cabolabs-ehrserver-master
grails -Dserver.port=8090 -Duser.timezone=UTC run-app
sleep infinity & wait
