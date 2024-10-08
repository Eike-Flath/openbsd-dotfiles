#!/bin/sh

[ -f /etc/profile ] && . /etc/profile

[ -n "$USER" ] || USER="$(id -un)"
readonly USER
export USER
[ -n "$HOME" ] || HOME="$(userinfo "$USER" | grep ^dir | cut -f 2)"
readonly HOME
export HOME

export PATH="$PATH:$HOME/.local/bin"
export MANPATH=":$HOME/.local/man"

# Dont't clutter my home dir!!! 
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export TERMINFO="$XDG_DATA_HOME/terminfo"
[ "$SHELL" = "/bin/ksh" ] && export ENV=$XDG_CONFIG_HOME/ksh.kshrc
export XAUTHORITY="$XDG_CONFIG_HOME/X11/Xauthority"
export XINITRC="$XDG_CONFIG_HOME/X11/xinit/xinitrc"

