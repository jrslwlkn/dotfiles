#!/bin/bash

if [ "$1" = "up" ]; then
	cp .gitconfig .zshrc .zprofile ~/
	cp init.lua ~/.config/nvim/
elif [ "$1" = "down" ]; then
	cp ~/.gitconfig ~/.zshrc ~/.zprofile ./
	cp ~/.config/nvim/init.lua ./
else 
	message="Usage:
	if passed 'up'   -> set system config from repo 
	if passed 'down' -> set repo config from system"
	echo "$message"
fi
