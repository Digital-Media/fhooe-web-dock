#!/bin/bash
# Installation has been done on Ubuntu 21.04 LTS (Focal Fossa) Desktop

echo "######################################################"
echo "## Setting debconf-settings for noninteractive mode ##"
echo "######################################################"
export DEBIAN_FRONTEND=noninteractive
sudo debconf-set-selections <<< 'mariadb-server-10.6 mysql-server/root_password password geheim'
sudo debconf-set-selections <<< 'mariadb-server-10.6 mysql-server/root_password_again password geheim'
      
echo "############################################"
echo "## Installing MariaDB 10.6 and PHPMyAdmin ##"
echo "############################################"
	  
sudo apt-get install software-properties-common dirmngr apt-transport-https
sudo apt-key adv --fetch-keys 'https://mariadb.org/mariadb_release_signing_key.asc'
sudo add-apt-repository 'deb [arch=amd64,arm64,ppc64el] https://mirror.vpsfree.cz/mariadb/repo/10.6/ubuntu hirsute main'
sudo apt update
sudo apt -y -qq install mariadb-server mariadb-client
sudo bash -c "mariadb -e \"CREATE USER 'onlineshop'@'localhost' IDENTIFIED BY 'geheim'\""
sudo bash -c "mariadb -e \"GRANT ALL PRIVILEGES ON *.* TO 'onlineshop'@'localhost'\""

sudo service mysql restart  && echo "MariaDB started with return $?"

