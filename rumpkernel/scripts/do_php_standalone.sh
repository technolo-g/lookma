#!/bin/bash -e

cd ../packages/php
make
rumpbake xen_pv bin/phpi.bin bin/php

sudo xl destroy php-standalone || echo 'php-standalone does not exist'

sudo /home/vagrant/rumprun/app-tools/rumprun xen \
  -d \
  -N php-standalone \
  -n inet,static,10.100.199.37/24 \
  -b images/data.iso,/data \
  -b images/stubetc.iso,/etc \
  -- bin/phpi.bin -S 0.0.0.0:80 -t /data/www

echo 'You can browse to:'
echo 'http://10.100.199.37'

