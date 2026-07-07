#!/usr/bin/env bash

cd "$(dirname "${BASH_SOURCE[0]}")"

git pull origin main

function doIt() {
	rsync --exclude ".git/" \
		--exclude ".gitea/" \
		--exclude ".gitignore" \
		--exclude ".DS_Store" \
		--exclude "bootstrap.sh" \
		--exclude "README.md" \
		-avh --no-perms . ~

	# Install or update the pure zsh prompt
	if [ -d "$HOME/.zsh/pure/.git" ]; then
		git -C "$HOME/.zsh/pure" pull --quiet
	else
		git clone --quiet https://github.com/sindresorhus/pure.git "$HOME/.zsh/pure"
	fi
}

if [ "$1" == "--force" ] || [ "$1" == "-f" ]; then
	doIt
else
	read -p "This may overwrite existing files in your home directory. Are you sure? (y/n) " -n 1
	echo ""
	if [[ $REPLY =~ ^[Yy]$ ]]; then
		doIt
	fi
fi
unset doIt
