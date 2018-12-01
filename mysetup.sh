#!/bin/bash

if cat /proc/version | grep -q 'ubuntu'; then
  set -o xtrace
  vim --version || sudo apt-get -y install vim;
  set +o xtrace
fi

sudo sh -c 'cat > ~/.vimrc << "EOF"
set number
set noautoindent
set tabstop=2
EOF'


exit 0;
