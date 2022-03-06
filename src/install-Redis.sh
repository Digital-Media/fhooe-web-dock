#!/bin/bash
# install Redis Server
cd $HOME/Downloads
wget http://download.redis.io/redis-stable.tar.gz
tar xzf redis-stable.tar.gz
sudo apt-get install tcl
cd redis-stable
make
make test
sudo bash -c "echo 'cd $HOME/Downloads/redis-stable' > /usr/local/bin/StartRedis.sh"
sudo bash -c "echo 'nohup ./src/redis-server ./redis.conf &>redis.out &' >> /usr/local/bin/StartRedis.sh"
sudo bash -c "echo 'sudo netstat -nlp|grep redis' >> /usr/local/bin/StartRedis.sh"
sudo bash -c "echo 'cd $HOME/Downloads/redis-stable'  > /usr/local/bin/StopRedis.sh"
var='pid=`ps -ef|grep redis|head -1|awk '
var+="'"
var+='{print $2}'
var+="'"
var+='`'
sudo chmod o+w /usr/local/src/StopRedis.sh
echo $var >> /usr/local/src/StopRedis.sh
sudo chmod o-w /usr/local/src/StopRedis.sh
sudo bash -c "echo 'kill -15 \$pid' >> /usr/local/bin/StopRedis.sh"
sudo bash -c "echo 'sleep 10' >> /usr/local/bin/StopRedis.sh"
sudo bash -c "echo 'sudo netstat -nlp|grep redis' >> /usr/local/bin/StopRedis.sh"
sudo bash -c "echo 'cd $HOME/Downloads/redis-stable'  >> /usr/local/bin/StopRedis.sh"
sudo bash -c "echo 'rm redis.out dump.rdb' >> /usr/local/bin/StopRedis.sh"
sudo chmod a+x /usr/local/src/*Redis.sh
cd $HOME/Downloads
rm redis-stable.tar.gz
sed -i 's/# requirepass foobared/requirepass geheim/g' $HOME/Downloads/redis-stable/redis.conf
sudo apt-get install php-redis
