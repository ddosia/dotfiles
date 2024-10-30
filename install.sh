. "$(dirname $(readlink -f $0))/lib/utils.sh"

include "bin/$(os_name).sh" || exit 666

git submodule update --init
cp -a home/. $HOME/
