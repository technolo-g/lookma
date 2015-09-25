#!/bin/bash

cd ../myblog/_mirage

# Configure our unikernel
mirage configure --xen

# Update the IP addresses in the config
perl -pi -e 's~10.0.0.2~10.100.199.41~g' main.ml
perl -pi -e 's~10.0.0.1~10.100.199.1~g' main.ml

# Pacakge our unikernel
make

# Kill any running instances
sudo xl destroy www || echo 'www unikernel does not exist!'

# Start a running instance
# Commented out to allow jitsu to run
# sudo xl create www.xl

#echo 'Browse to:'
#echo 'http://mirageos.unikornel.com'

echo 'Start jitsu using the provided script.'
echo 'Then show that there are no unikernels running:'
echo 'sudo xl list'
echo 'Then run the following command in another terminal to start the unikernel:'
echo 'dig @10.100.199.35 jitsu.unikornel.com'
echo '(or browse to http://jitsu.unikornel.com)'
echo '...and show its running!'
echo 'sudo xl list'

