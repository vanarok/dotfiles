#!/bin/sh

pkg update -y
pkg upgrade -y

pkg install -y glab-cli helix git-delta python

pip install shell-gpt