#!/bin/bash

include "lib/utils.sh" || exit 666

################
### Homebrew
function brew_install {
    if ! command -v brew >/dev/null 2>&1; then
        NONINTERACTIVE=1 /bin/bash -c \
            "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    fi
    # Apple Silicon -> /opt/homebrew, Intel -> /usr/local
    if [[ -x /opt/homebrew/bin/brew ]]; then
        eval "$(/opt/homebrew/bin/brew shellenv)"
    else
        eval "$(/usr/local/bin/brew shellenv)"
    fi
}
###
################

################
### Brewfile
function brew_bundle_install {
    brew bundle install --file="$(base_dir)/Brewfile"
}
###
################

################
### mise
# tool versions are defined in ~/.config/mise/config.toml (home/.config/mise/config.toml
# in this repo), already in place by the time this runs -- see install.sh
function mise_install {
    mise install
    eval "$(mise activate bash)"
}
###
################

brew_install
echo ""
brew_bundle_install
echo ""
mise_install
