#!/bin/bash -e

cd ../packages/php

# Build PHP
make

# Package our unikernel
rumpbake xen_pv bin/php-cgi.bin bin/php-cgi

# Destroy any running kernels
sudo xl destroy php-fastcgi-daemon || echo 'php-fastcgi-daemon does not exist'

# Start our kernel
sudo /home/vagrant/rumprun/app-tools/rumprun xen \
  -d \
  -M 1024 \
  -N php-fastcgi-daemon \
  -n inet,static,10.100.199.38/24 \
  -b images/data.iso,/data \
  -b images/stubetc.iso,/etc \
  -e PHP_FCGI_MAX_REQUESTS=0 \
  -- bin/php-cgi.bin -b 8000

echo 'PHP Has been started!'

