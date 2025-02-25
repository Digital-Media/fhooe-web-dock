#!/bin/bash

echo "## Enabling HTTPS for Apache ##"

# Enable necessary modules
a2enmod ssl
a2enmod headers
a2ensite default-ssl

# Create SSL directory and generate certificate
mkdir -p /etc/apache2/ssl
openssl req -new -newkey rsa:4096 -nodes -x509 -days 3650 \
    -keyout /etc/apache2/ssl/localhost.key \
    -out /etc/apache2/ssl/localhost.crt \
    -subj "/C=AT/ST=Upper Austria/L=Hagenberg im Mühlkreis/O=FH Oberösterreich/OU=Department of Digital Media/CN=localhost" \
    -utf8 -nameopt lname,multiline,utf8 \
    -extensions SAN \
    -config <(cat /etc/ssl/openssl.cnf \
    <(printf "\n[SAN]\nsubjectAltName=DNS:localhost,DNS:localhost.localdomain,IP:127.0.0.1"))

# Configure default-ssl site
sed -i '/DocumentRoot \/var\/www\/html/r /dev/stdin' /etc/apache2/sites-enabled/default-ssl.conf << EOF

	<Directory /var/www/html>
		Options Indexes FollowSymLinks MultiViews
		IndexOptions +IgnoreCase +FoldersFirst
		AllowOverride All
	</Directory>
EOF

# Update SSL certificate and key paths
sed -i 's+/etc/ssl/certs/ssl-cert-snakeoil.pem+/etc/apache2/ssl/localhost.crt+g' /etc/apache2/sites-enabled/default-ssl.conf
sed -i 's+/etc/ssl/private/ssl-cert-snakeoil.key+/etc/apache2/ssl/localhost.key+g' /etc/apache2/sites-enabled/default-ssl.conf

# Restart Apache
apache2ctl restart
