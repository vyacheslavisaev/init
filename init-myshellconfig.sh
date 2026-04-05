#!/usr/bin/env bash

set -e

echo "Initialising MY shell environment!"
echo "You should have valid access to github."
echo "In case process fails, fix access and re-start initialisation."

MY_SHELL_CONFIG_PATH="${HOME}/myshellconfig"

git clone git@github.com:vyacheslavisaev/myshellconfig.git ${MY_SHELL_CONFIG_PATH}

cd ${MY_SHELL_CONFIG_PATH}
echo "Installing MY shell environment!"

./install.sh
