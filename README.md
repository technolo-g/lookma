## Look Ma, no OS! Interactive Demo
This repository contains the demo material for my talk entitled:
**Look Ma, no OS! Unikernels and Their Applications**

There are very simple 3 demos:
- MirageOS
- Rumprun
- Runtime JS

## Rumprun
In order to demonstrate the Rumprun unikernel, we will stand up a very basic WordPress stack. This involves:
- Preparing the system
- Building and starting the MySQL unikernel
- Building and starting the PHP unikernel
- Building and starting the NGINX unikernel
- Running through the WordPress install

In order to get this demo going, please perform the following steps:
```
# Running from the shared directory is slow on VMware and
# terrible on VirtualBox so we'll clone it to the local fs.
git clone https://github.com/technolo-g/lookma
cd lookma/rumprun/scripts
./0_prepare.sh

# Fire up MySQL
./1_mysql.sh

# Fire up PHP
./2_php.sh

# Fire up NGINX
./3_nginx.sh
```

You may now browse to `http://10.100.199.39` and complete the WordPress installation. Please note that it does go pretty slow right now.

## Runtime JS
There are two demos in the `runtimejs` directory:
- hello-world: This is a very basic demo that will build a unikernel that outputs the text 'Hello StrangeLoop!' on the console out.
- webserver: This is a simple webserver written in JS that responds to all requests on port 9000 with a 200 response code and the text 'Hello StrangeLoop!'

In order to build and run the demos run the following commands (from within the Vagrant box):
```
# Running from the shared directory is slow on VMware and
# terrible on VirtualBox so we'll clone it to the local fs.
git clone https://github.com/technolo-g/lookma
cd lookma/runtimejs/scripts
./0_prepare.sh

# Run the hello-world demo:
cd ~/lookma/runtimejs/scripts
./demo-helloworld.sh
cd ../hello-world && npm start

# Run the webserver demo:
cd ~/lookma/runtimejs/scripts
./demo-webserver.sh
cd ../webserver && npm start
```
