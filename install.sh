#!/bin/bash

function ubuntu_install {
    sudo apt-get update;
    echo ""
    ubuntu_dev_essentials_install
    echo ""
    ubuntu_py_install
    echo ""
    ubuntu_js_install
    echo ""
    ubuntu_terraform_install
    echo ""
    ubuntu_docker_install
    echo ""
    ubuntu_k8_install
    echo ""
    ubuntu_erl_install
    echo ""
    ubuntu_elixir_install
    echo ""
    ubuntu_keybase_install
    echo ""
    ubuntu_github_install
    echo ""
    ubuntu_aws_install
}

################
### dev essentials
function ubuntu_dev_essentials_install {
    sudo apt install build-essential autoconf automake make gdb gcc g++ \
        libffi-dev zlib1g-dev libssl-dev \
        git tmux vim htop colordiff jq net-tools thefuck inotify-tools
}
###
################

################
### Python
function ubuntu_py_install {
    echo "Please read pyenv installation notes on https://github.com/pyenv/pyenv"
    sudo apt install --no-install-recommends \
        libssl-dev zlib1g-dev libbz2-dev \
        libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev xz-utils \
        tk-dev libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev

    PY_V=$( pyenv install --list | grep -v - | grep "[[:space:]]\+3\.[[:digit:]]\+\.[[:digit:]]\+$" | tail -1 )
    pyenv install ${PY_V}
    pyenv global ${PY_V}

    python -m pip install -U pip
    python -m pip install -U -r requirements.txt
}
###
################

################
### JS
function ubuntu_js_install {
    # ASDF nodejs plugin
    sudo apt-get install -y dirmngr gpg curl gawk

    asdf plugin add nodejs https://github.com/asdf-vm/asdf-nodejs.git
    asdf install nodejs latest
    asdf global nodejs latest

    asdf plugin-add yarn
    asdf install yarn latest
    asdf global yarn latest
}
###
################

################
### terraform
function ubuntu_terraform_install {
    tfenv install latest
    tfenv use latest
}
###
################

################
### K8
function ubuntu_k8_install {
    # https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/install-kubeadm/
    sudo apt install apt-transport-https ca-certificates curl
    sudo curl -fsSLo /usr/share/keyrings/kubernetes-archive-keyring.gpg https://packages.cloud.google.com/apt/doc/apt-key.gpg
    echo "deb [signed-by=/usr/share/keyrings/kubernetes-archive-keyring.gpg] https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee /etc/apt/sources.list.d/kubernetes.list
    sudo apt-get update
    sudo apt-get install -y kubelet kubeadm kubectl
    sudo apt-mark hold kubelet kubeadm kubectl
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

################
### erlang
function ubuntu_erl_install {
    sudo apt install xsltproc fop libxml2-utils # need to build erl docs
    asdf plugin add erlang
    asdf install erlang latest
    asdf global erlang latest
}
###
################

################
### elixir
function ubuntu_elixir_install {
    asdf plugin add elixir
    asdf install elixir latest
    asdf global elixir latest
    # mix local.hex
    # mix local.rebar --force
}
###
################

################
### keybase
function ubuntu_keybase_install {
    curl --remote-name https://prerelease.keybase.io/keybase_amd64.deb --output-dir /tmp
    sudo apt install /tmp/keybase_amd64.deb
}
###
################

################
### github
function ubuntu_github_install {
    curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg
    sudo chmod go+r /usr/share/keyrings/githubcli-archive-keyring.gpg
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null
    sudo apt update
    sudo apt install gh
}
###
################

################
### AWS
function ubuntu_aws_install {
    ## session manager plugin
    curl "https://s3.amazonaws.com/session-manager-downloads/plugin/latest/ubuntu_64bit/session-manager-plugin.deb" -o "/tmp/session-manager-plugin.deb"
    sudo dpkg -i /tmp/session-manager-plugin.deb
}
###
################

./install.fs.sh

case "$(uname -s)" in
    Linux*) ubuntu_install;;
esac
