#!/bin/bash

cd ../webserver

# Compile our app with rebar
../tools/rebar g-d clean compile

# Package our app with railing
../tools/railing image --name vmling

# Cleanup
mv vmling.img vmling
rm -rf ebin domain_config

