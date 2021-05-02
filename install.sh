#!/bin/bash

function ubuntu_install {
    sudo apt-get update;
    echo ""
    ubuntu_dev_essentials_install
    echo ""
    ubuntu_pyenv_install
    echo ""
    sudo apt install awscli
    echo ""
    ubuntu_terraform_install
}

function mac_install {
    xcode-select --install
    brew update
    mac_dev_essentials_install
    echo ""
    mac_pyenv_install
    echo ""
    brew install awscli
    echo ""
    mac_terraform_install
}

################
### dev essentials
function ubuntu_dev_essentials_install {
    sudo apt install build-essential autoconf automake gdb libffi-dev zlib1g-dev libssl-dev
    sudo apt install git tmux vim htop colordiff
}

function mac_dev_essentials_install {
    brew install coreutils findutils gnu-tar gnu-sed gawk gnutls gnu-indent gnu-getopt grep
    brew install git tmux vim bash bash-completion htop wget curl colordiff
    brew install autoconf automake libtool
}
###
################


################
### pyenv
function ubuntu_pyenv_install {
    echo "Please read pyenv installation notes on https://github.com/pyenv/pyenv"
    sudo apt install --no-install-recommends make build-essential libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev
}

function mac_pyenv_install {
    echo "Please read pyenv installation notes on https://github.com/pyenv/pyenv"
    brew install openssl readline sqlite3 xz zlib
}
###
################

################
### terraform
function ubuntu_terraform_install {
    echo "Please read terraform installation notes on https://learn.hashicorp.com/tutorials/terraform/install-cli"
    sudo curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
    sudo apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
    sudo apt-get update && sudo apt-get install terraform packer
    terraform -install-autocomplete
}

function mac_terraform_install {
    echo "Please read terraform installation notes on https://learn.hashicorp.com/tutorials/terraform/install-cli"
    brew tap hashicorp/tap
    brew install hashicorp/tap/terraform
    terraform -install-autocomplete

    brew install hashicorp/tap/packer
}
###
################


case "$(uname -s)" in
    Linux*) ubuntu_install;;
    Darwin*) mac_install;;
esac

################
### common install
PY_V=$(pyenv install --list | grep -v - | grep -v b | tail -1)
pyenv install ${PY_V}
pyenv global ${PY_V}

python -m pip install -U pip
python -m pip install -U matplotlib
python -m pip install -U pandas
python -m pip install -U jupyter
###
################

./install.fs.sh
