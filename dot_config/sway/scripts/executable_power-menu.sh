#!/bin/bash

entries="Break Logout Reboot Shutdown"

selected=$(printf '%s\n' $entries | bemenu -m eDP-1 | awk '{print tolower($1)}')

case $selected in
  break)
    exec safeeyes --take-break;;
  logout)
    swaymsg exit;;
  reboot)
    exec systemctl reboot;;
  shutdown)
    exec systemctl poweroff -i;;
esac
