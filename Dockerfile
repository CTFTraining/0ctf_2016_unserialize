FROM php:5.6-fpm-alpine

LABEL Author="Virink <virink@outlook.com>"
LABEL Blog="https://www.virzz.com"

COPY files /tmp/

RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.ustc.edu.cn/g' /etc/apk/repositories \
    && apk add --update --no-cache nginx mysql mysql-client \
    && docker-php-source extract \
    && docker-php-ext-install mysql \
    && docker-php-source delete \
    && mysql_install_db --user=mysql --datadir=/var/lib/mysql \
    && sh -c 'mysqld_safe &' \
	&& sleep 5s \
    && mysqladmin -uroot password 'qwertyuiop' \
    && mysql -e "source /tmp/db.sql;" -uroot -pqwertyuiop \
    && mkdir /run/nginx \
    && mv /tmp/docker-php-entrypoint /usr/local/bin/docker-php-entrypoint \
    && mv /tmp/nginx.conf /etc/nginx/nginx.conf \
    && mv /tmp/vhost.nginx.conf /etc/nginx/conf.d/default.conf \
    && mv /tmp/src/* /var/www/html \
    && chmod -R -w /var/www/html \
    && chmod -R 777 /var/www/html/upload \
    && chown -R www-data:www-data /var/www/html \
    && rm -rf /tmp/* \
    && rm -rf /etc/apk

EXPOSE 80

VOLUME ["/var/log/nginx"]

CMD ["/bin/sh", "-c", "docker-php-entrypoint"]