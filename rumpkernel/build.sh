#!/bin/bash

cd ~/
git clone https://github.com/technolo-g/rumprun-packages.git
cd rumprun-packages/
mv config.mk.dist config.mk
perl -pi -e 's~RUMPRUN_TOOLCHAIN_TUPLE=.*~RUMPRUN_TOOLCHAIN_TUPLE=x86_64-rumprun-netbsd~g' config.mk
cd nginx
make
rumpbake xen_pv ./nginx.bin bin/nginx

