#!/bin/bash

cd ../packages/php

make
rumpbake xen_pv bin/php-cgi.bin bin/php-cgi

sudo xl destroy php-fastcgi-daemon || echo 'php-fastcgi-daemon does not exist'

sudo /home/vagrant/rumprun/app-tools/rumprun xen \
  -d \
  -N php-fastcgi-daemon \
  -n inet,static,10.100.199.38/24 \
  -b images/data.iso,/data \
  -b images/stubetc.iso,/etc \
  -e PHP_FCGI_MAX_REQUESTS=0 \
  -- bin/php-cgi.bin -b 8000

cd ../nginx_php

make

rumpbake xen_pv ./nginx.bin bin/nginx

sudo xl destroy php-fastcgi-nginx || echo 'php-fastcgi-nginx does not exist'

sudo /home/vagrant/rumprun/app-tools/rumprun xen \
  -d \
  -N php-fastcgi-nginx \
  -n inet,static,10.100.199.39/24 \
  -b images/data.iso,/data \
  -b images/stubetc.iso,/etc \
  -- ./nginx.bin -c /data/conf/nginx.conf


echo 'You can browse to:'
echo 'http://10.100.199.39'

