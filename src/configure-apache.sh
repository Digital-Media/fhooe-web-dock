#!/bin/bash
# Apache2
echo ServerName localhost >> /etc/apache2/apache2.conf
a2enmod rewrite

cd /etc/apache2/sites-enabled

sed -i '29i <Directory /var/www/html>' 000-default.conf
sed -i '30i        Options Indexes FollowSymLinks MultiViews' 000-default.conf
sed -i '31i        AllowOverride All' 000-default.conf
sed -i '32i </Directory>' 000-default.conf

apache2ctl restart