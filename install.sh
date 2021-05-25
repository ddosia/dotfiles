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
    echo ""
    ubuntu_docker_install
}

################
### dev essentials
function ubuntu_dev_essentials_install {
    sudo apt install build-essential autoconf automake gdb libffi-dev zlib1g-dev libssl-dev
    sudo apt install git tmux vim htop colordiff jq
}
###
################


################
### pyenv
function ubuntu_pyenv_install {
    echo "Please read pyenv installation notes on https://github.com/pyenv/pyenv"
    sudo apt install --no-install-recommends make build-essential libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev
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
###
################

################
### docker
function ubuntu_docker_install {
    ## https://docs.docker.com/engine/install/ubuntu/
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
    echo \
          "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
            $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
    sudo apt-get update
    sudo apt-get install docker-ce docker-ce-cli containerd.io
    sudo usermod -aG docker $USER
    sudo systemctl enable docker.service
    sudo systemctl enable containerd.service
    echo "to check the docker work run: 'docker run hello-world'; You may need to logout/login for $USER to gain necessary permissions."
}
###
################

case "$(uname -s)" in
    Linux*) ubuntu_install;;
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
