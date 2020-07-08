FROM debian:buster

LABEL maintainer="jkang"

RUN apt-get update -y
RUN apt-get upgrade -y

#install nginx
RUN apt-get install -y nginx
RUN apt-get install -y wget

#원래는 ssl 파일을 따로 추가해주려고 했지만 빌드할 때 생성해서 넣는 것으로 변경
#RUN mkdir -p /etc/nginx/ssl
#COPY ./srcs/server.key /etc/nginx/ssl/server.key
#COPY ./srcs/server.crt /etc/nginx/ssl/server.crt

#install php for mysql and myphpadmin
RUN apt install -y php7.3-cli php7.3-fpm php7.3-mysql php7.3-json php7.3-opcache php7.3-mbstring php7.3-xml php7.3-gd php7.3-curl

COPY ./srcs/nginx.config /etc/nginx/sites-available/default

#install mysql(mariadb) for DB
RUN apt install -y mariadb-server mariadb-client

#install phpmyadmin
COPY ./srcs/pma_install.sh /root/pma_install.sh
RUN bash /root/pma_install.sh

COPY ./srcs/config.inc.php /var/www/html/phpmyadmin/config.inc.php

#install WordPress

COPY ./srcs/wordpress.tar.gz /root/wordpress.tar.gz

#ADD https://wordpress.org/latest.tar.gz /wordpress.tar.gz
RUN tar xvzf /root/wordpress.tar.gz
RUN rm /root/wordpress.tar.gz
RUN mv /wordpress /var/www/html/

COPY ./srcs/wp-config.php /var/www/html/wordpress/wp-config.php
RUN chown -R www-data:www-data /var/www/
RUN chmod 755 -R /var/www/

#SSL setting

RUN mkdir -p /etc/nginx/ssl
RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
	-subj '/C=KR/ST=Seoul/L=Gangnam/O=42Seoul/CN=ft_server' \
	-keyout /etc/nginx/ssl/server.key -out /etc/nginx/ssl/server.crt

#bash shell commands as soon as a container is made
COPY ./srcs/start.sh /root/start.sh
WORKDIR /root
CMD bash start.sh && tail -f /dev/null

EXPOSE 80 443