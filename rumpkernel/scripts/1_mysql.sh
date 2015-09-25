#!/bin/bash -e

cd ../packages/mysql
# Remove any existing images
rm -f images/data.ffs images/tmp.ffs

# Build MySQL
make

# Package MySQL as a unikernel
rumpbake xen_pv ./mysqld.bin bin/mysqld

# Destroy any running instances
sudo xl destroy mysql-standalone || echo 'mysql-standalone does not exist'

# Start a new running instance of MySQL
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

# Wait for MySQL to start
sleep 10

# Create our grants for WordPress
mysql -h 10.100.199.40 -u rump -e 'create database wordpress;'
mysql -h 10.100.199.40 -u rump -e 'grant all on wordpress.* to wordpress@"%" identified by "wordpress";'
mysql -h 10.100.199.40 -u rump -e 'flush privileges;'

echo 'You can connect to MySQL by:'
echo 'mysql -h 10.100.199.40 -u rump'
echo 'or'
echo 'mysql -h rump-mysql.unikornel.com -u rump'

