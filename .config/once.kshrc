#!/bin/ksh

set -eu

# Install dwm
echo "Installing dwm..."
cd
mkdir -p .local/src
cd .local/src
git clone http://github.org/Eike-Flath/dwm.git
cd dwm
make install
cd

echo "Installing st..."
cd .local/src
git clone http://github.org/Eike-Flath/st.git
cd st
make install
cd

echo "Successfully set up your dotfiles"
sleep 2
clear

