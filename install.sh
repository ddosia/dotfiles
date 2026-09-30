#!/bin/bash
. "$(dirname $(readlink -f $0))/lib/utils.sh"

git submodule update --init
cp -a home/. $HOME/

# .bashrc/.bash_profile aren't deployed via cp -a since Ubuntu ships real
# content in ~/.bashrc that shouldn't be clobbered -- just make sure
# .my_bashrc actually gets loaded, on top of whatever's already there.
ensure_line "$HOME/.bashrc" '[[ -f "$HOME/.my_bashrc" ]] && . "$HOME/.my_bashrc"'
ensure_line "$HOME/.bash_profile" '[[ -f "$HOME/.bashrc" ]] && . "$HOME/.bashrc"'

include "bin/$(os_name).sh" || exit 666
