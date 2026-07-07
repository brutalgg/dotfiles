# Overview
This dotfile repository contains configuration for the following tools:

- Bash
- ZSH (with the [pure](https://github.com/sindresorhus/pure) prompt)
- tmux
- git
- gnupg
- screen

The canonical copy lives on a self-hosted Gitea instance; a Gitea push mirror
(repo Settings → Repository → Mirror Settings) syncs every push to
[GitHub](https://github.com/brutalgg/dotfiles).

# Installation
**Warning:** Use these dotfiles at your own risk. These will overwrite some
operating system default settings.

## Git and bootstrap

You can clone the repository wherever you want. The bootstrapper script will
pull in the latest version, copy the files to your home folder, and install
(or update) the pure zsh prompt.

```bash
git clone https://github.com/brutalgg/dotfiles.git && cd dotfiles
./bootstrap.sh
```

Pass `-f`/`--force` to skip the confirmation prompt.

## Specify the $PATH
If `~/.path` exists, it will be sourced before all other files (by both bash
and zsh), so machine-specific PATH entries stay out of the repo.

Here's an example `~/.path` file that adds `/usr/local/bin` to the `$PATH`:

```bash
export PATH="/usr/local/bin:$PATH"
```

## Machine-specific git identity
`.gitconfig` includes `~/.gitconfig-user` for repos under `~/code/`.
`.gitconfig-work` is a template — fill in the placeholders and enable the
commented `includeIf` block in `.gitconfig` on work machines.
