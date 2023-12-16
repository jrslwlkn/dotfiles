#!/bin/bash

if [ "$1" = "up" ]; then
	cp .gitconfig .zshrc .zprofile ~/.
	cp init.lua ~/.config/nvim/
	cp kitty.conf ~/.config/kitty/
	source ~/.zprofile & source ~/.zshrc & wait
elif [ "$1" = "down" ]; then
	cp ~/.gitconfig ~/.zshrc ~/.zprofile ~/.config/nvim/init.lua ~/.config/kitty/kitty.conf ./
else 
	message="Usage:
	if passed 'up'   -> set system config from repo 
	if passed 'down' -> set repo config from system"
	echo "$message"
fi
