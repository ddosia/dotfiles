#!/bin/bash
## Everything related to home files/dirs init on a fresh machine is here

git submodule update --init
cp -a home/. $HOME/
