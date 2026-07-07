#!/usr/bin/env bash

cd "$(dirname "${BASH_SOURCE[0]}")"

force=0
dryrun=0
for arg in "$@"; do
	case "$arg" in
		-f|--force) force=1 ;;
		-n|--dry-run) dryrun=1 ;;
		*) echo "usage: $0 [-f|--force] [-n|--dry-run]"; exit 1 ;;
	esac
done

function doIt() {
	if [ -d .git ]; then
		git pull origin main
	fi

	rsync --exclude ".git/" \
		--exclude ".gitignore" \
		--exclude ".DS_Store" \
		--exclude "bootstrap.sh" \
		--exclude "README.md" \
		-avh --no-perms . ~

	# GnuPG refuses to load configs from a directory with loose permissions
	chmod 700 ~/.gnupg
	chmod 600 ~/.gnupg/*.conf

	# Install or update the pure zsh prompt
	if [ -d "$HOME/.zsh/pure/.git" ]; then
		git -C "$HOME/.zsh/pure" pull --quiet
	else
		git clone --quiet https://github.com/sindresorhus/pure.git "$HOME/.zsh/pure"
	fi
}

if [ "$dryrun" -eq 1 ]; then
	echo "Dry run: these files would be copied to $HOME"
	rsync --exclude ".git/" \
		--exclude ".gitignore" \
		--exclude ".DS_Store" \
		--exclude "bootstrap.sh" \
		--exclude "README.md" \
		-avhn --no-perms . ~
	exit 0
fi

if [ "$force" -eq 1 ]; then
	doIt
else
	read -p "This may overwrite existing files in your home directory. Are you sure? (y/n) " -n 1
	echo ""
	if [[ $REPLY =~ ^[Yy]$ ]]; then
		doIt
	fi
fi
unset doIt
