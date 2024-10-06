[ -f /etc/profile ] && . /etc/profile

[ -n "$USER" ] || USER="$(id -un)"
readonly USER
export USER
[ -n "$HOME" ] || HOME="$(userinfo "$USER" | grep ^dir | cut -f 2)"
readonly HOME
export HOME

ENV=$HOME/.config/kshrc

