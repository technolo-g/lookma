#!/bin/bash -e

cd ../packages/mysql
rm -f images/data.ffs 
make
rumpbake xen_pv ./mysqld.bin bin/mysqld

sudo xl destroy mysql-standalone || echo 'mysql-standalone does not exist'

sudo /home/vagrant/rumprun/app-tools/rumprun xen \
  "$@" -M 1024 \
  -d \
  -N mysql-standalone \
  -n inet,static,10.100.199.40/24 \
  -b images/data.ffs,/data \
  -b images/tmp.ffs,/tmp \
  -b images/stubetc.iso,/etc \
  -- mysqld.bin \
        --defaults-file=/data/my.cnf --basedir=/data --user=daemon --tmpdir=/tmp

sleep 10

mysql -h 10.100.199.40 -u rump -e 'create database wordpress;'
mysql -h 10.100.199.40 -u rump -e 'grant all on wordpress.* to wordpress@"%" identified by "wordpress";'
mysql -h 10.100.199.40 -u rump -e 'flush privileges;'

echo 'You can browse to:'
echo 'mysql -h 10.100.199.40 -u rump'

