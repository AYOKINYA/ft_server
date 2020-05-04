#!/bin/bash

wget https://files.phpmyadmin.net/phpMyAdmin/4.9.4/phpMyAdmin-4.9.4-all-languages.tar.gz
mkdir /var/www/html/phpmyadmin/
tar -zxvf phpMyAdmin-4.9.4-all-languages.tar.gz --strip-components=1 -C /var/www/html/phpmyadmin
rm phpMyAdmin-4.9.4-all-languages.tar.gz