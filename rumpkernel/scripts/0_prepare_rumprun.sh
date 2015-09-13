#!/bin/bash -e

sudo apt-get install -y libxen-dev genisoimage realpath libssl-dev cmake makefs mysql-client-core-5.5

cd ~/
git clone https://github.com/technolo-g/rumprun.git
cd rumprun
git submodule update --init
./build-rr.sh xen

if grep -Fxq "app-tools" ~/.bashrc; then
  echo 'bashrc already configured'
  echo 'Type the following command to activate:'
  echo '. ~/.bashrc'
else
  echo "PATH=\${PATH}:$(pwd)/app-tools" >> ~/.bashrc
  echo 'bashrc has been configured'
  echo 'Type the following command to activate:'
  echo '. ~/.bashrc'
fi

