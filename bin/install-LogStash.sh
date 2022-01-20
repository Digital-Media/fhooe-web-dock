sudo apt install logstash
sudo bash -c "echo 'sudo systemctl start logstash' >> /usr/local/bin/StartLogstash.sh"
sudo bash -c "echo 'sudo systemctl stop logstash' >> /usr/local/bin/StopLogstash.sh"
sudo chmod a+x /usr/local/bin/*Logstash.sh

sudo bash -c "echo 'input {
  beats {
    port => 5044
  }
}' > /etc/logstash/conf.d/02-beats-input.conf"
sudo bash -c "echo 'output {
  if [@metadata][pipeline] {
    elasticsearch {
    hosts => [\"localhost:9200\"]
    manage_template => false
    index => \"%{[@metadata][beat]}-%{[@metadata][version]}-%{+YYYY.MM.dd}\"
    pipeline => \"%{[@metadata][pipeline]}\"
    }
  } else {
    elasticsearch {
    hosts => [\"localhost:9200\"]
    manage_template => false
    index => \"%{[@metadata][beat]}-%{[@metadata][version]}-%{+YYYY.MM.dd}\"
    }
  }
}' > /etc/logstash/conf.d/30-elasticsearch-output.conf"
sudo -u logstash /usr/share/logstash/bin/logstash --path.settings /etc/logstash -t
# Should display
# Config Validation Result: OK. Exiting Logstash
sudo apt-get install libpostgresql-jdbc-java
# workarounds due to bugs
sudo cp /usr/share/java/postgresql.jar /usr/share/logstash/logstash-core/lib/jars
