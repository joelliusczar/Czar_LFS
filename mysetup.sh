#!/bin/bash

if cat /proc/version | grep -q 'ubuntu'; then
  vim --version || sudo apt-get -y install vim;
fi

sudo sh -c 'cat > ~/.vimrc << "EOF"
set number
set noautoindent
set tabstop=2
EOF'

git config --global user.email "joelliuscaesar@gmail.com"
git config --global user.name "Joel Gillete"

if [ -e 'experiment_files/test_setup.sh' ]; then
  bash test_setup.sh
fi

exit 0;
