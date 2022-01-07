#!/bin/bash
cd /home/vagrant
echo "#########################################"
echo "## Installing PHPMyAdmin latest        ##"
echo "## and link it to Apache Document Root ##"
echo "#########################################"
sudo bash -c "mariadb -e \"CREATE DATABASE phpmyadmin\""
sudo bash -c "mariadb -e \"GRANT ALL ON phpmyadmin.* TO phpmyadmin@localhost IDENTIFIED BY 'geheim';\""
wget https://files.phpmyadmin.net/phpMyAdmin/5.1.1/phpMyAdmin-5.1.1-english.tar.gz
tar xvf phpMyAdmin-5.1.1-english.tar.gz
sudo mv phpMyAdmin-*/ /usr/share/phpmyadmin
sudo mkdir -p /var/lib/phpmyadmin/tmp
sudo chown -R www-data:www-data /var/lib/phpmyadmin
sudo cp /usr/share/phpmyadmin/config.sample.inc.php /usr/share/phpmyadmin/config.inc.php
# sudo apt-install -y -qq pwgen
sudo ln -s /usr/share/phpmyadmin/ /var/www/html/phpmyadmin

## all passwords are set to "geheim"