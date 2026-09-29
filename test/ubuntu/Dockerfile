FROM ubuntu:26.04

ENV DEBIAN_FRONTEND=noninteractive

# sudo/git/ca-certificates are what a real fresh Ubuntu install already has
# (first user has sudo, and you need git to have cloned this repo at all) --
# everything else must come from install.sh itself.
RUN apt-get update && \
    apt-get install -y --no-install-recommends sudo ca-certificates git && \
    rm -rf /var/lib/apt/lists/*

ARG USERNAME=tester
RUN useradd -m -s /bin/bash ${USERNAME} && \
    echo "${USERNAME} ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/${USERNAME} && \
    chmod 0440 /etc/sudoers.d/${USERNAME}

USER ${USERNAME}
WORKDIR /home/${USERNAME}/dotfiles
COPY --chown=${USERNAME}:${USERNAME} . .

ENV DOTFILES_SKIP_SERVICES=1
CMD ["./install.sh"]
