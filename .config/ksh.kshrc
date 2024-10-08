#!/bin/ksh

clear

ONCE_FILE="$XDG_CONFIG_HOME/once.kshrc"
if [ -f "$ONCE_FILE" ]
then
	ksh "$ONCE_FILE" && rm "$ONCE_FILE"
fi
unset ONCE_FILE

PS1='\W \$ ' 

case $- in
*l*) # Login shell
	if [ "$(tty)" = "/dev/ttyC0" ] && [ -z "$DISPLAY" ]
	then
		exec startx
	fi
	;;
esac

