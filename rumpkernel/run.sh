#!/bin/bash

cd /home/vagrant/rumprun-packages/nginx

make
sudo xl destroy rumprun-nginx.bin
sudo /home/vagrant/rumprun/app-tools/rumprun xen \
  -d \
  -n inet,static,10.100.199.36/24 \
  -b images/data.iso,/data \
  -b images/stubetc.iso,/etc \
  -- ./nginx.bin -c /data/conf/nginx.conf

