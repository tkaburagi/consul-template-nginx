#!/usr/bin/env bash

### Docker
sudo apt-get -y update
sudo apt-get -y install \
     apt-transport-https \
     ca-certificates \
     curl \
     gnupg-agent \
     software-properties-common

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo apt-key fingerprint 0EBFCD88
sudo add-apt-repository \
    "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"

sudo apt-get -y install docker-ce docker-ce-cli containerd.io

### Consul-template
sudo apt-get -y install unzip
curl "${ct_url}" --output ~/ct.zip
sudo unzip ~/ct.zip -d /usr/local/bin/
sudo chmod +x /usr/local/bin/consul-template
rm ~/ct.zip