#!/bin/bash
# echo "####################################"
# echo "## Installing ElasticSearch 7.7.0 ##"
# echo "####################################"
# done according to https://www.elastic.co/guide/en/elasticsearch/reference/current/deb.html#deb-repo

sudo apt-get install apt-transport-https
wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | sudo apt-key add -
sudo bash -c 'echo "deb https://artifacts.elastic.co/packages/7.x/apt stable main" > /etc/apt/sources.list.d/elastic-7.x.list'
sudo apt-get update
sudo apt-get install elasticsearch

# configuring elasticsearch for localhost only.
# https://www.elastic.co/guide/en/elasticsearch/reference/current/important-settings.html
# https://www.elastic.co/guide/en/elasticsearch/reference/7.7/breaking-changes-7.7.html#breaking_77_discovery_changes
# if your hardware does support more cpus, cores and memory you might want to upgrade from default virtual machine settings.
# 2 or more cores,  4 to 8GB memory
# sudo vi /etc/elasticsearch/elasticsearch.yml
# network.host: localhost
# cluster.name: myShopCluster1
# node.name: "myShopNode1"

# sudo /bin/systemctl enable elasticsearch.service
sudo bash -c "echo 'sudo systemctl start elasticsearch.service' >> /usr/local/bin/StartElasticSearch.sh"
sudo bash -c "echo 'sudo systemctl stop elasticsearch.service' >> /usr/local/bin/StopElasticSearch.sh"
sudo chmod a+x /usr/local/bin/*ElasticSearch.sh
echo "## cloning and installing german dictionary ##'
cd $HOME/Downloads
git clone https://github.com/uschindler/german-decompounder.git
sudo mkdir /etc/elasticsearch/analysis
sudo cp $HOME/Downloads/german-decompounder/de_DR.xml /etc/elasticsearch/analysis
sudo cp $HOME/Downloads/german-decompounder/dictionary-de.txt /etc/elasticsearch/analysis
echo "## starting JRE and elasticsearch - that can take a while ##"
sudo systemctl start elasticsearch.service
echo "## testing connection ##"
curl -X GET http://localhost:9200
