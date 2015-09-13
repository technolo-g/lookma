#!/bin/bash

if grep -Fxq "app-tools" ~/.bashrc; then
  echo 'bashrc already configured'
  . ~/.bashrc
else
  echo 'PATH=${PATH}:$(pwd)/app-tools'  >> ~/.bashrc
  . ~/.bashrc
fi

