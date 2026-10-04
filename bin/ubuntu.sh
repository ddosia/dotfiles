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
    sudo apt install -y --no-install-recommends \
        build-essential autoconf automake make gdb gcc g++ \
        libffi-dev zlib1g-dev libssl-dev \
        git tmux vim htop colordiff jq net-tools inotify-tools \
        `# nodejs` \
        dirmngr gpg curl gawk \
        `# erlang` \
        xsltproc fop libxml2-utils libncurses-dev \
        `# python` \
        libssl-dev zlib1g-dev libbz2-dev \
        libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev xz-utils \
        tk-dev libxml2-dev libxmlsec1-dev libffi-dev lzma liblzma-dev \
        cargo `# required to build cryptography (ansible dep) from source`
}
###
################

################
### mise
# tool versions are defined in ~/.config/mise/config.toml (home/.config/mise/config.toml
# in this repo), already in place by the time this runs -- see install.sh
function mise_install {
    if ! command -v mise >/dev/null 2>&1; then
        add_apt_repo \
            mise \
            https://mise.jdx.dev/gpg-key.pub \
            https://mise.jdx.dev/deb stable main
        sudo apt update
        sudo apt install -y mise
    fi
    mise install
    eval "$(mise activate bash)"
}
###
################

################
### VS Code
function vscode_install {
    sudo snap install code --classic
}
###
################

################
### Antigravity
function ai_antigravity {
    # Antigravity IDE (v2.5+ standalone IDE based on VS Code)
    if ! snap list antigravity-ide-snap >/dev/null 2>&1; then
        sudo snap install antigravity-ide-snap --classic
    fi
    sudo snap alias antigravity-ide-snap.antigravity-ide antigravity-ide 2>/dev/null || true
    sudo snap alias antigravity-ide-snap.antigravity-ide antigravity 2>/dev/null || true

    if [[ -x /snap/bin/antigravity-ide-snap.antigravity-ide ]]; then
        sudo ln -sf /snap/bin/antigravity-ide-snap.antigravity-ide /usr/local/bin/antigravity-ide
        sudo ln -sf /snap/bin/antigravity-ide-snap.antigravity-ide /usr/local/bin/antigravity
    fi

    ## cli version has to be installed separately
    curl -fsSL https://antigravity.google/cli/install.sh | bash
}
###
################



################
### docker
function docker_install {
    sudo apt-get install -y docker.io
    sudo usermod -aG docker $USER
    sudo systemctl enable --now docker.service
    echo "to check the docker work run: 'docker run hello-world'; You may need to logout/login for $USER to gain necessary permissions."
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
mise_install

# skip steps needing systemd/snapd (not available in the plain container the
# local Docker test harness runs against - see test/ubuntu/Dockerfile)
if [[ -z "${DOTFILES_SKIP_SERVICES:-}" ]]; then
    echo ""
    docker_install
    echo ""
    do_install
    echo ""
    vscode_install
    echo ""
    ai_antigravity
fi
