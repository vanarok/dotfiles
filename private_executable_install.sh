#!/usr/bin/env bash


if [[ -n "$TERMUX_APP_PID" ]]; then
    pkg install chezmoi
else
    sudo apt install chezmoi
fi


chezmoi apply
