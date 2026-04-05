#!/bin/bash

set -e

# Get the directory of this script
SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &> /dev/null && pwd)"

echo "Initialising SSH"

SSH_CONFIG_FILE="$HOME/.ssh/config"

if [[ ! -f ${SSH_CONFIG_FILE} ]]; then
    echo "Creating SSH config file"
    cp ssh/config ${SSH_CONFIG_FILE}
    chmod 600 ${SSH_CONFIG_FILE}
else
    echo "SSH config file already exists, skipping"
fi

SSH_CONF_D="$HOME/.ssh/config.d"

if [[ ! -d ${SSH_CONF_D} ]]; then
    echo "Creating SSH config.d directory"
    mkdir ${SSH_CONF_D}
else
    echo "SSH config.d directory already exists, skipping"
fi

SSH_GIT_HUB_CONFIG_SRC="${SCRIPT_DIR}/ssh/github.conf"
SSH_GIT_HUB_CONFIG_DEST="$SSH_CONF_D/github.conf"

if [[ ! -f ${SSH_GIT_HUB_CONFIG_DEST} ]]; then
    echo "Creating SSH config for GitHub"
    cp ${SSH_GIT_HUB_CONFIG_SRC} ${SSH_GIT_HUB_CONFIG_DEST}
else
    echo "SSH config for GitHub already exists, skipping"
fi

SSH_GIT_HUB_KEY="$HOME/.ssh/github-key"

if [[ -f ${SSH_GIT_HUB_KEY} ]]; then
    echo "SSH key for GitHub already exists, skipping"
    exit 0
fi

# Prompt for email
read -p "Enter your email for SSH key: " USER_EMAIL

ssh-keygen -t ed25519 -C "$USER_EMAIL" -f ${SSH_GIT_HUB_KEY} -N ""

echo "SSH key for GitHub created at ${SSH_GIT_HUB_KEY}"
echo "Public key:"
cat ${SSH_GIT_HUB_KEY}.pub

echo "Add the above public key to your GitHub account..."

while true; do
    read -p "Have you configured GitHub account? (y/N): " yn
    case $yn in
        [Yy])
            break
            ;;
        [Nn])
            echo "Please, add the public key to your GitHub account before continuing..."
            ;;
        *)
            echo "Please answer Y or N."
            ;;
    esac
done
