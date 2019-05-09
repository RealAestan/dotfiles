#!/bin/sh
dbus-update-activation-environment --systemd DISPLAY
eval "$(/usr/bin/gnome-keyring-daemon --start --components=pkcs11,secrets,ssh)"
export SSH_AUTH_SOCK
tmux new-session -d -s mail 'protonmail-bridge --cli'
[ -x "$(command -v cronsct)" ] && cronsct
exec i3
