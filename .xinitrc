#!/bin/sh
dbus-update-activation-environment --systemd DISPLAY
eval "$(/usr/bin/gnome-keyring-daemon --start --components=pkcs11,secrets,ssh)"
export SSH_AUTH_SOCK
tmux new-session -d -s mail 'protonmail-bridge --cli'
if [ -x "$(command -v sct)" ]; then
    _hour=$(date +%H)
    if [ "$_hour" -ge 18 ] || [ "$_hour" -le 5 ]; then
        sct 3500
    else
        sct
    fi
fi
exec i3
