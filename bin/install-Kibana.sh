sudo apt install kibana
sudo bash -c "echo 'sudo systemctl start kibana' >> /usr/local/bin/StartKibana.sh"
sudo bash -c "echo 'sudo systemctl stop kibana' >> /usr/local/bin/StopKibana.sh"
sudo chmod a+x /usr/local/bin/*Kibana.sh
sudo bash -c "echo 'StartElasticSearch.sh' > /usr/local/bin/StartELK.sh"
sudo bash -c "echo 'StartLogstash.sh' >> /usr/local/bin/StartELK.sh"
sudo bash -c "echo 'StartKibana.sh' >> /usr/local/bin/StartELK.sh"
sudo bash -c "echo 'StopKibana.sh' >> /usr/local/bin/StopELK.sh"
sudo bash -c "echo 'StopLogstash.sh' >> /usr/local/bin/StopELK.sh"
sudo bash -c "echo 'StopElasticSearch.sh' > /usr/local/bin/StopELK.sh"
sudo chmod a+x /usr/local/bin/*ELK.sh
