#!/bin/bash
# Runs install.sh inside a throwaway Ubuntu container to check the
# fresh-machine install path. Docker/k8s/snap steps are skipped
# (DOTFILES_SKIP_SERVICES=1) since they need systemd/snapd that a plain
# container doesn't run.
set -euo pipefail

repo_root="$(cd "$(dirname "$0")/.." && pwd)"
image_tag="dotfiles-ubuntu-test"

# Builds from the working tree as-is (including uncommitted edits), so this
# is useful while actively fixing things. Submodules already checked out on
# this host come along too, so `git submodule update --init` inside the
# container is a fast local no-op rather than a real fresh clone -- fine for
# testing the install logic itself.
docker build -q -t "$image_tag" -f "$repo_root/test/ubuntu/Dockerfile" "$repo_root" >/dev/null

docker run --rm "$image_tag"
