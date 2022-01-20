sudo apt install filebeat
sudo bash -c "echo 'sudo systemctl start filebeat' >> /usr/local/bin/StartFilebeat.sh"
sudo bash -c "echo 'sudo systemctl stop filebeat' >> /usr/local/bin/StopFilebeat.sh"
sudo chmod a+x /usr/local/bin/*Filebeat.sh

