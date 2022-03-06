#!/src/bash
# Installation has been done on Ubuntu 21.04 LTS (Focal Fossa) Desktop
# Repos for PHP 8.1
sudo add-apt-repository -y ppa:ondrej/php
# Apache2
sudo add-apt-repository -y ppa:ondrej/apache2
sudo apt-get -y update

echo "#############################################"
echo "## Installing Apache2, PHP8.1 + Extensions ##"
echo "#############################################"

sudo apt-get -y install apache2 php8.1 libapache2-mod-php8.1
sudo apt-get -y install php8.1-zip php8.1-mysql php8.1-curl php8.1-dev php8.1-gd php8.1-intl php-pear php-imagick php8.1-imap php8.1-tidy php8.1-xmlrpc php8.1-xsl php8.1-mbstring php8.1-xml php-xdebug

echo "###############################################"
echo "## Activating SSL and mod_rewrite for Apache ##"
echo "###############################################"

sudo a2enmod rewrite
sudo a2enmod ssl
sudo a2ensite default-ssl

echo "################################"
echo "# Activating XDEBUG for Apache #"
echo "################################"

INI=/etc/php/8.1/mods-available/xdebug.ini

sudo bash -c "echo 'xdebug.remote_enable=1' >> $INI"
sudo bash -c "echo 'xdebug.remote_connect_back=1' >> $INI"
sudo bash -c "echo 'xdebug.remote_port=9000' >> $INI"


echo "########################################"
echo "## Adding permanent redirect to HTTPs ##"
echo "########################################"
cd /etc/apache2/sites-available
sudo sed -i '29i #' 000-default.conf
sudo sed -i '30i # Redirct permanently to https ' 000-default.conf
sudo sed -i '31i # added by Martin Harrer for demonstration purposes in web lessons' 000-default.conf

# welche IP verwenden, falls wir von außen zugreifen? Im Image passt localhost
# bekommt jeder clone seine eigene IP-Adresse?
# Ist die statisch oder kommt die von DHCP?
sudo sed -i '32i Redirect permanent / https://localhost/' 000-default.conf

echo "#############################################################"
echo "## Switching to AllowOverride All for /var/www/html/code/* ##"
echo "#############################################################"
cd /etc/apache2/sites-available
sudo sed -i '131i <Directory /var/www/html/code/*>' default-ssl.conf
sudo sed -i '132i        Options Indexes FollowSymLinks MultiViews' default-ssl.conf
sudo sed -i '133i        AllowOverride All' default-ssl.conf
sudo sed -i '134i </Directory>' default-ssl.conf

echo "######################################################"
echo "## Setting debconf-settings for noninteractive mode ##"
echo "######################################################"
export DEBIAN_FRONTEND=noninteractive
sudo debconf-set-selections <<< 'mariadb-server-10.6 mysql-server/root_password password geheim'
sudo debconf-set-selections <<< 'mariadb-server-10.6 mysql-server/root_password_again password geheim'
      
echo "############################################"
echo "## Installing MariaDB 10.6 and PHPMyAdmin ##"
echo "############################################"
	  
sudo apt-key adv --fetch-keys 'https://mariadb.org/mariadb_release_signing_key.asc'
sudo add-apt-repository 'deb [arch=amd64,arm64,ppc64el] http://sfo1.mirrors.digitalocean.com/mariadb/repo/10.6/ubuntu focal main'sudo apt-get -y update
sudo apt-get -y -qq install mariadb-server mariadb-client
sudo mysql -uroot -pgeheim -e "CREATE USER 'onlineshop'@'localhost' IDENTIFIED BY 'geheim'"
sudo mysql -uroot -pgeheim -e "GRANT ALL PRIVILEGES ON *.* TO 'onlineshop'@'localhost'"
## all passwords are set to "geheim"
sudo apt-get -y -qq install phpmyadmin

echo "################################################"
echo "## Linking PHPMyAdmin to Apache Document Root ##"
echo "################################################"
sudo ln -s /usr/share/phpmyadmin/ /var/www/html/phpmyadmin

sudo service apache2 restart  && echo "Apache started with return code $?"
sudo service mysql restart  && echo "MariaDB started with return $?"

echo "## Installing PHPCodeSniffer ##"

cd $HOME/Downloads
sudo curl -s -Ol https://squizlabs.github.io/PHP_CodeSniffer/phpcs.phar
sudo curl -s -Ol https://squizlabs.github.io/PHP_CodeSniffer/phpcbf.phar
sudo mv phpcs.phar /usr/local/bin/phpcs
sudo mv phpcbf.phar /usr/local/bin/phpcbf
cd /usr/local/bin
sudo chown root:root phpcs phpcbf
sudo chmod 755 phpcs phpcbf

echo "## Installing composer ##"

cd /home/ubuntu
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

sudo mv composer.phar /usr/local/bin/composer
sudo chown root:root /usr/local/bin/composer
