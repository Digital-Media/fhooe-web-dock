#!/bin/bash

echo "## Enabling HTTPS for Apache ##"
a2enmod ssl
a2enmod headers
a2ensite default-ssl

cd /etc/apache2
mkdir -p ssl
cd ssl

openssl req -new -newkey rsa:4096 -nodes -x509 -days 3650 -keyout localhost.key -out localhost.crt -subj "/C=AT/ST=Upper Austria/L=Hagenberg im Mühlkreis/O=FH Oberösterreich/OU=Department of Digital Media/CN=localhost" -utf8 -nameopt lname,multiline,utf8 -extensions SAN -config <( cat /etc/ssl/openssl.cnf <(printf "\n[SAN]\nsubjectAltName=DNS:localhost,DNS:localhost.localdomain,IP:127.0.0.1"))


cd ../sites-enabled

sed -i '131i <Directory /var/www/html>' default-ssl.conf
sed -i '132i        Options Indexes FollowSymLinks MultiViews' default-ssl.conf
sed -i '133i        AllowOverride All' default-ssl.conf
sed -i '134i </Directory>' default-ssl.conf
sed -i '135i Header always set Strict-Transport-Security "max-age:63072000; includeSubdomains"' default-ssl.conf
sed -i 's+/etc/ssl/certs/ssl-cert-snakeoil.pem+/etc/apache2/ssl/localhost.crt+g' default-ssl.conf
sed -i 's+/etc/ssl/private/ssl-cert-snakeoil.key+/etc/apache2/ssl/localhost.key+g' default-ssl.conf

apache2ctl restart
