#!/bin/bash -e

sudo apt-get install -y software-properties-common
sudo add-apt-repository -y ppa:avsm/ppa
sudo apt-get update && sudo apt-get install -y curl build-essential m4 ocaml opam libgmp-dev libpcre3-dev libxen-dev pkg-config

opam init -y
opam switch 4.01.0 -y
opam update -y
opam install depext -y
opam depext xenctrl libvirt xen-api-client
opam install mirage -y
opam install jitsu -y


echo '#####   Run this to activate Mirage! ######'
echo 'eval `opam config env`'

