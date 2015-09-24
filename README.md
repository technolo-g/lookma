## Look Ma, no OS! Interactive Demo
This repository contains the demo material for my talk entitled:
** Look Ma, no OS! Unikernels and Their Applications **

There are very simple 3 demos:
- MirageOS
- Rumprun
- Runtime JS

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
