#!/bin/sh

set -eu

die() {
	echo "$1"
	exit 1
}

[ "$(uname)" = "OpenBSD" ] || die "this script is written for OpenBSD"
[ $(id -u) -eq 0 ] || die "run this as root"
[ -n "${1-}" ] || die "usage: $0 <user name>"

DOTFILES_ROOT="$(realpath "$(dirname "$0")")"

echo "checking for internet access..."
ping -c 1 openbsd.org >/dev/null || die "failed to ping openbsd.org"
clear

for p in $(<"$DOTFILES_ROOT/pkglist")
do
	echo "installing pkg '$p'..."
	pkg_add $p
done
clear

echo "installing FiraCode font..."
cd
mkdir firacode
cd firacode
curl --fail --location --show-error https://github.com/tonsky/FiraCode/releases/download/6.2/Fira_Code_v6.2.zip -o firacode.zip
unzip firacode.zip
mkdir -p /usr/local/share/fonts/TTF
mv ttf/*.ttf /usr/local/share/fonts/TTF/
cd
rm -rf firacode
clear

echo "creating user..."
USER_NAME="$1"
userinfo -e "$USER_NAME" && die "the user $USER_NAME already exists" 
groupinfo -e users || die "group users does not exist"
groupinfo -e wheel || die "group wheel does not exist"
[ -x /bin/ksh ] || die "/bin/ksh doesn't exist"
set -x
useradd -m -s /bin/ksh -k "$DOTFILES_ROOT" -g users -G wheel "$USER_NAME"
passwd "$USER_NAME"
set +x
clear

USER_HOME="$(userinfo "$USER_NAME" | grep ^dir | cut -f 2)"
for f in $(<"$DOTFILES_ROOT/.dotfileignore")
do
	rm -rf "$USER_HOME/$f"
done

echo "login as $USER_NAME to finish installation" 


