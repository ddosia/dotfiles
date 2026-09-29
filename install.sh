#!/bin/bash
. "$(dirname $(readlink -f $0))/lib/utils.sh"

git submodule update --init
cp -a home/. $HOME/

include "bin/$(os_name).sh" || exit 666
