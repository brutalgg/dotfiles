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

Pass `-f`/`--force` to skip the confirmation prompt, or `-n`/`--dry-run` to
preview which files would be overwritten without changing anything.

# Machine-specific customization
`bootstrap.sh` **copies** files into `$HOME`, so local edits to tracked files
are overwritten on the next run. Anything machine-specific belongs in one of
these untracked files instead:

## `~/.path` — PATH entries
Sourced *first* by both bash and zsh, before any feature detection. Example:

```bash
export PATH="/usr/local/bin:$PATH"
```

## `~/.features` — opt-in features
The dotfiles work on both macOS and Linux. Features that not every machine
needs are off by default; enable them in `~/.features`, which is read by
`bootstrap.sh` and sourced right after `~/.path` by both shells:

```bash
DOTFILES_GPG=1   # sync ~/.gnupg, start gpg-agent, use it as the SSH agent
DOTFILES_SOPS=1  # sops-enc / sops-dec helpers (key: $SOPS_AGE_KEY_FILE)
```

With `DOTFILES_GPG=1` on macOS, `bootstrap.sh` points gpg-agent at
`pinentry-mac` if it is installed; on Linux the system default pinentry is
used. Re-run `bootstrap.sh` after changing `DOTFILES_GPG`.

## `~/.extra` — everything else
Sourced *last* by both bash and zsh. Use it for aliases, exports, and
settings you don't want to commit (work tooling, secrets, one-off hosts):

```bash
export SOPS_AGE_KEY_FILE="$HOME/.sops/key.txt"
alias vpn="sudo wg-quick up wg0"
```

## Git identity
`.gitconfig` includes `~/.gitconfig-user` for repos under `~/code/`.
`.gitconfig-work` is a template — fill in the placeholders and enable the
commented `includeIf` block in `.gitconfig` on work machines.
