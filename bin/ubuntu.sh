#!/bin/bash

include "lib/utils.sh" || exit 666
source /etc/os-release

add_apt_repo() {
    REPO_NAME=$1; shift;
    GPG_URL=$1; shift;
    REPO_URL=$1; shift;
    COMPONENT=$@

    KEY_DIR=/etc/apt/keyrings
    KEY_PATH="${KEY_DIR}/$REPO_NAME-keyring.asc"

## seems that apt works fine with "asc" keys without dearmoring them
## if it doesn't, following helps (resultin key has to have .gpg extension)
#    curl -fsSL $GPG_URL \
#        | sudo gpg --yes --batch --dearmor -o $KEY_PATH && \

    sudo curl -fsSLo $KEY_PATH $GPG_URL && \
    sudo chmod a+r $KEY_PATH && \
    echo "deb [signed-by=$KEY_PATH] $REPO_URL $COMPONENT" \
        | sudo tee /etc/apt/sources.list.d/$REPO_NAME.list

}


################
### dev essentials
function dev_essentials_install {
    sudo apt install --no-install-recommends \
        build-essential autoconf automake make gdb gcc g++ \
        libffi-dev zlib1g-dev libssl-dev \
        git tmux vim htop colordiff jq net-tools thefuck inotify-tools \
        sshuttle direnv gnome-shell-pomodoro \
        `# nodejs` \
        dirmngr gpg curl gawk \
        `# erlang` \
        xsltproc fop libxml2-utils libncurses-dev \
        `# python` \
        libssl-dev zlib1g-dev libbz2-dev \
        libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev xz-utils \
        tk-dev libxml2-dev libxmlsec1-dev libffi-dev lzma lzma-dev liblzma-dev \
        cargo `# required for some deps from requirements.txt`
}
###
################

################
### Python
function py_install {
    python -m pip install -U pip
    python -m pip install -U -r requirements.txt
    asdf reshim python
}
###
################

################
### asdf
# most of the tools are defined in home/.tool-versions
function asdf_install {
    tools=$( \
        cat $(base_dir)/home/.tool-versions \
        | cut -d' ' -f1 \
        | grep "^[^\#]" \
    )
    for t in $tools; do
        asdf plugin add $t
    done
    cd $(base_dir)/home && asdf install && cd -;
    for t in $tools; do
        asdf global $t latest
    done
}
###
################

################
### K8
function k8_install {
    K8S_VER=v1.31
    # https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/install-kubeadm/
    sudo apt install apt-transport-https ca-certificates curl

    add_apt_repo \
        k8s \
        https://pkgs.k8s.io/core:/stable:/$K8S_VER/deb/Release.key \
        https://pkgs.k8s.io/core:/stable:/$K8S_VER/deb/ /

    sudo apt-get update
    sudo apt-get install -y kubelet kubeadm kubectl
    sudo apt-mark hold kubelet kubeadm kubectl
    sudo systemctl enable --now kubelet
}
###
################

################
### docker
function docker_install {
    ## https://docs.docker.com/engine/install/ubuntu/
    sudo apt-get install ca-certificates curl

    add_apt_repo \
        docker \
        https://download.docker.com/linux/ubuntu/gpg \
        https://download.docker.com/linux/ubuntu \
        $VERSION_CODENAME stable

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
### elixir
function elixir_install {
    mix local.hex --if-missing
    mix local.rebar --if-missing
    mix archive.install hex phx_new --force
}
###
################

################
### AWS
function aws_install {
    ## session manager plugin
    sudo apt install -y awscli

    curl "https://s3.amazonaws.com/session-manager-downloads/plugin/latest/ubuntu_64bit/session-manager-plugin.deb" \
        -o "/tmp/session-manager-plugin.deb" && \
    sudo dpkg -i /tmp/session-manager-plugin.deb

}
###
################

################
### DigitalOcean
function do_install {
    # https://docs.digitalocean.com/reference/doctl/how-to/install/
    sudo snap install doctl
}
###
###############
#
sudo apt-get update;
echo ""
dev_essentials_install
echo ""
sdf_install
echo ""
py_install
echo ""
docker_install
echo ""
k8_install
echo ""
elixir_install
echo ""
aws_install
echo ""
do_install
