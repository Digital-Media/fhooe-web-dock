#!/bin/bash

echo "## Installing zip, unzip, curl, net-tools ##"
apt-get -y install curl git iputils-ping less nano net-tools openssl psmisc telnet unzip vim wget zip man-db

echo "## Installing GitHub CLI ##"
curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg
chmod go+r /usr/share/keyrings/githubcli-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | tee /etc/apt/sources.list.d/github-cli.list > /dev/null
apt-get update -y
apt-get install gh -y
