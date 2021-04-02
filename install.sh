#!/bin/bash

## SUBMODULES
echo "Initializing submodules"
git submodule update --init
for s in $( git config --file .gitmodules --name-only --get-regexp "path$" | sed 's/submodule.\(.*\).path/\1/' ); do
    mkdir -p "$(dirname "${HOME}/${s}")"
    ln -frTvs $s ~/$s
done;
echo ""

function ubuntu_install {
    sudo apt-get update;
    echo ""
    ubuntu_pyenv_install
    echo ""
    sudo apt install awscli
    echo ""
    sudo apt install ubuntu_terraform_install
}

function mac_install {
    xcode-select --install
    brew update
    echo ""
    mac_pyenv_install
    echo ""
}

function ubuntu_pyenv_install {
    echo "Please read pyenv installation notes on https://github.com/pyenv/pyenv"
    sudo apt install --no-install-recommends make build-essential libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev
}

function ubuntu_terraform_install {
    echo "Please read terraform installation notes on https://learn.hashicorp.com/tutorials/terraform/install-cli"
    sudo curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
    sudo apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
    sudo apt-get update && sudo apt-get install terraform
    terraform -install-autocomplete
}

function mac_pyenv_install {
    echo "Please read pyenv installation notes on https://github.com/pyenv/pyenv"
    brew install openssl readline sqlite3 xz zlib
}


case "$(uname -s)" in
    Linux*) ubuntu_install;;
    Darwin*) mac_install;;
esac
