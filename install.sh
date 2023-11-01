#!/usr/bin/env bash


if [[ -n "$TERMUX_APP_PID" ]]; then
    echo "Is TERMUX environment"
    pkg install chezmoi
else
    echo "Is NOT TERMUX environment"
    sudo apt install chezmoi
fi


chezmoi apply
