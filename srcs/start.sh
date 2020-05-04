#!/bin/bash

#ln -s /etc/nginx/sites-available/default /etc/nginx/sites-enabled/
service nginx start
service php7.3-fpm start

touch /var/run/mysqld.socket
chmod 755 /var/run/mysqld.socket
service mysql start

#mysql -u root -e 'set password = password("123456789")'
mysql -u root -e "CREATE DATABASE wordpress;"
mysql -u root -e "CREATE USER 'wpuser'@'localhost' IDENTIFIED BY '123456789';"
mysql -u root -e "GRANT ALL PRIVILEGES ON wordpress.* TO wpuser@localhost;"
mysql -u root -e "FLUSH PRIVILEGES;"
mysql -u root -e "update mysql.user set plugin = 'mysql_native_password' where user='root';"

#mysql -u root -p123456789 -e "CREATE DATABASE wordpress;"
#mysql -u root -p123456789 -e "CREATE USER 'wpuser'@'localhost' IDENTIFIED BY '123456789';"
#mysql -u root -p123456789 -e "GRANT ALL PRIVILEGES ON wordpress.* TO wpuser@localhost;"
#mysql -u root -p123456789 -e "FLUSH PRIVILEGES;"

bash