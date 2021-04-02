#!/bin/bash
## Everything related to home files/dirs init on a fresh machine is here

################
### SUBMODULES
echo "Initializing submodules"
git submodule update --init
for s in $( git config --file .gitmodules --name-only --get-regexp "path$" | sed 's/submodule.\(.*\).path/\1/' ); do
    mkdir -p "$(dirname "${HOME}/${s}")"
    ln -frTvs $s ~/$s
done;
echo ""
###
################
