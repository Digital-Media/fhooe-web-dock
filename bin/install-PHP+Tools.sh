#!/bin/bash
echo "################################"
echo "# Activating XDEBUG for Apache #"
echo "################################"
apt-get install -y php-xdebug
INI=/etc/php/8.1/mods-available/xdebug.ini

bash -c "echo 'xdebug.remote_enable=1' >> $INI"
bash -c "echo 'xdebug.remote_connect_back=1' >> $INI"
bash -c "echo 'xdebug.remote_port=9000' >> $INI"

service apache2 restart  && echo "Apache started with return code $?"

echo "## Installing PHPCodeSniffer ##"

cd /tmp
curl -s -Ol https://squizlabs.github.io/PHP_CodeSniffer/phpcs.phar
curl -s -Ol https://squizlabs.github.io/PHP_CodeSniffer/phpcbf.phar
mv phpcs.phar /usr/local/bin/phpcs
mv phpcbf.phar /usr/local/bin/phpcbf
cd /usr/local/bin
chown root:root phpcs phpcbf
chmod 755 phpcs phpcbf

echo "## Installing composer ##"

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

cp /src/bin/phpinfo.php /var/www/html