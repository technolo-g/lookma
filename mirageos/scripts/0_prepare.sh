#!/bin/bash -e

# Install apt tools
sudo apt-get install -y software-properties-common

# Add the OCaml PPA
sudo add-apt-repository -y ppa:avsm/ppa

# Install OCaml / Opam
sudo apt-get update
sudo apt-get install -y curl build-essential m4 ocaml opam \
  libgmp-dev libpcre3-dev libxen-dev pkg-config

# Init Opam
opam init -y

# Switch to OCaml 4.01.0
opam switch 4.01.0 -y

# Update opam
opam update -y

# Install our dependency manager
opam install depext -y

# Install our deps
opam depext xenctrl libvirt xen-api-client

# Install the mirage package (unikernel packaging tool)
opam install mirage -y

# Install jitsu (Just In Time Summoning of Unikernels)
opam install jitsu -y

echo '#####   Run this to activate Mirage! ######'
echo 'eval `opam config env`'

