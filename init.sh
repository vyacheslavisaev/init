#!/bin/bash

echo "Initialising new environment!"

echo "Switching to bash shell"

chsh -s /bin/bash

./init-ssh.sh

echo "Switching to ssh repo..."
git remote set-url origin git@github.com:vyacheslavisaev/init.git

echo "Initialisation complete!"