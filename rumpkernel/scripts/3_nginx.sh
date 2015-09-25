#!/bin/bash -e

cd ../packages/nginx_php

# Compile NGINX
make

# Package our unikernel
rumpbake xen_pv ./nginx.bin bin/nginx

# Destroy any running instances
sudo xl destroy php-fastcgi-nginx || echo 'php-fastcgi-nginx does not exist'

# Start our unikernel
sudo /home/vagrant/rumprun/app-tools/rumprun xen \
  -d \
  -M 512 \
  -N php-fastcgi-nginx \
  -n inet,static,10.100.199.39/24 \
  -b images/data.iso,/data \
  -b images/stubetc.iso,/etc \
  -- ./nginx.bin -c /data/conf/nginx.conf


echo 'You can browse to WordPress at:'
echo 'http://rumprun.unikornel.com'

