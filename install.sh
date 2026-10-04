. "$(dirname $(readlink -f $0))/lib/utils.sh"

git submodule update --init
cp -a home/. $HOME/

grep -qxF 'source $HOME/.my_bashrc' ~/.bashrc || echo 'source $HOME/.my_bashrc' >> ~/.bashrc

include "bin/$(os_name).sh" || exit 666
