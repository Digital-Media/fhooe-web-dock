#!/bin/bash

echo "## Configuring Apache and root directory ##"

# Add ServerName to apache2.conf
echo ServerName localhost >> /etc/apache2/apache2.conf

# Enable rewrite module
a2enmod rewrite

# Configure default site
sed -i '/DocumentRoot \/var\/www\/html/r /dev/stdin' /etc/apache2/sites-enabled/000-default.conf << EOF

	<Directory /var/www/html>
		Options Indexes FollowSymLinks MultiViews
		IndexOptions +IgnoreCase +FoldersFirst
		AllowOverride All
	</Directory>
EOF

# Restart Apache
apache2ctl restart
