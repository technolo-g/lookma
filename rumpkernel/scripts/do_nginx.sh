#!/bin/bash

cd ../packages/nginx
make
rumpbake xen_pv ./nginx.bin bin/nginx

sudo xl destroy nginx-standalone || echo 'nginx-standalone does not exist'

sudo /home/vagrant/rumprun/app-tools/rumprun xen \
  -d \
  -N nginx-standalone \
  -n inet,static,10.100.199.36/24 \
  -b images/data.iso,/data \
  -b images/stubetc.iso,/etc \
  -- ./nginx.bin -c /data/conf/nginx.conf

echo 'You can browse to:'
echo 'http://10.100.199.36'

