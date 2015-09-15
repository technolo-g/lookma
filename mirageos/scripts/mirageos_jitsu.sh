sudo /home/vagrant/.opam/4.01.0/bin/jitsu \
--bind=0.0.0.0 \
--forwarder=8.8.8.8 \
--ttl=30 \
--backend=libxl \
dns=www.example.org,\
ip=10.100.199.41,\
kernel=../myblog/_mirage/mir-www.xen,\
memory=64000,\
name=www,\
nic=xenbr0
