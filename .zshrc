# If ~/.path exists, source it first so PATH is set before anything else
[ -r ~/.path ] && source ~/.path

# Opt-in feature flags (DOTFILES_GPG, DOTFILES_SOPS); see README
[ -r ~/.features ] && source ~/.features

fpath+=("$HOME/.zsh/pure")
autoload -U promptinit; promptinit
autoload -Uz compinit && compinit -i
prompt pure

# set history options
HISTFILE="${HOME}/.zsh_history"
HISTSIZE=2000
SAVEHIST=2000
setopt HIST_NO_STORE
setopt SHARE_HISTORY

if [ "${DOTFILES_GPG:-0}" = 1 ] && command -v gpgconf > /dev/null 2>&1; then
	export GPG_TTY="$(tty)"
	export SSH_AUTH_SOCK="$(gpgconf --list-dirs agent-ssh-socket)"
	gpgconf --launch gpg-agent
fi

source ~/.aliases

# Machine-specific settings that should never be tracked in the repo
[ -r ~/.extra ] && source ~/.extra

# Show system info when opening a terminal
command -v fastfetch > /dev/null 2>&1 && fastfetch
