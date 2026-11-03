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

[ -r ~/.features ] && source ~/.features

excludes=(
	--exclude ".git/"
	--exclude ".gitignore"
	--exclude ".DS_Store"
	--exclude "bootstrap.sh"
	--exclude "README.md"
)
[ "${DOTFILES_GPG:-0}" = 1 ] || excludes+=(--exclude ".gnupg/")

function configureGpg() {
	# GnuPG refuses to load configs from a directory with loose permissions
	chmod 700 ~/.gnupg
	chmod 600 ~/.gnupg/*.conf

	if [ "$(uname)" = "Darwin" ]; then
		for pinentry in "$(command -v pinentry-mac)" /opt/homebrew/bin/pinentry-mac /usr/local/bin/pinentry-mac; do
			if [ -x "$pinentry" ]; then
				echo "pinentry-program $pinentry" >> ~/.gnupg/gpg-agent.conf
				break
			fi
		done
	fi
}

function doIt() {
	if [ -d .git ]; then
		git pull origin main
	fi

	rsync "${excludes[@]}" -avh --no-perms . ~

	[ "${DOTFILES_GPG:-0}" = 1 ] && configureGpg

	# Install or update the pure zsh prompt
	if command -v zsh > /dev/null 2>&1; then
		if [ -d "$HOME/.zsh/pure/.git" ]; then
			git -C "$HOME/.zsh/pure" pull --quiet
		else
			git clone --quiet https://github.com/sindresorhus/pure.git "$HOME/.zsh/pure"
		fi
	fi
}

if [ "$dryrun" -eq 1 ]; then
	echo "Dry run: these files would be copied to $HOME"
	rsync "${excludes[@]}" -avhn --no-perms . ~
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
