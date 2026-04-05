#!/bin/bash

echo "Initialising new environment!"

echo "Switching to bash shell"

chsh -s /bin/bash

git clone git@github.com:vyacheslavisaev/init.git init-env

cd init-env
./init-ssh.sh

echo "Switching to ssh git repo..."
git remote set-url origin git@github.com:vyacheslavisaev/init.git

echo
echo "Installing Homebrew..."
echo
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
echo "Homebrew installed!"
echo
echo "Initialisation complete!"
echo