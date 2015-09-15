#!/bin/bash

cd ../myblog/_mirage
mirage configure --xen
perl -pi -e 's~10.0.0.2~10.100.199.41~g' main.ml
perl -pi -e 's~10.0.0.1~10.100.199.1~g' main.ml
make
sudo xl destroy www
sudo xl create www.xl

echo 'Browse to:'
echo 'http://10.100.199.41'
