#!/usr/bin/env bash


if [[ -n "$TERMUX_APP_PID" ]]; then
    pkg install chezmoi
else
    echo "Is NOT TERMUX environment"
fi

sudo apt install chezmoi


chezmoi apply
