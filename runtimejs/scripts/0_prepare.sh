#!/bin/bash -e

sudo apt-get -y install curl qemu
curl --silent --location https://deb.nodesource.com/setup_0.12 | sudo bash -
sudo apt-get install --yes nodejs

# install dependencies
sudo npm install runtimeify -g
sudo npm install runtime-tools -g

sudo chown -R vagrant.vagrant ~/.npm

echo 'Now you can run the Runtime JS Demos!'
