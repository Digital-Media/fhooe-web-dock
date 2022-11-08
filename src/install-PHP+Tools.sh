#!/bin/bash

echo "## Installing Composer ##"
cd /tmp
EXPECTED_SIGNATURE="$(wget -q -O - https://composer.github.io/installer.sig)"
php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
ACTUAL_SIGNATURE="$(php -r "echo hash_file('sha384', 'composer-setup.php');")"

if [ "$EXPECTED_SIGNATURE" != "$ACTUAL_SIGNATURE" ]
then
    >&2 echo 'ERROR: Invalid installer signature'
    rm composer-setup.php
    exit 1
fi

php composer-setup.php --quiet
RESULT=$?
rm composer-setup.php
echo $RESULT

mv composer.phar /usr/local/bin/composer
chown root:root /usr/local/bin/composer

echo "## Creating xdebug.ini ##"
tee -a /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini <<EOF

[xdebug]
xdebug.mode=debug,develop,coverage
xdebug.discover_client_host=1
xdebug.client_host=host.docker.internal
EOF
