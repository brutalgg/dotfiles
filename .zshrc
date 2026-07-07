# If ~/.path exists, source it first so PATH is set before anything else
[ -r ~/.path ] && source ~/.path

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

if command -v gpgconf > /dev/null 2>&1; then
	export GPG_TTY="$(tty)"
	export SSH_AUTH_SOCK="$(gpgconf --list-dirs agent-ssh-socket)"
	gpgconf --launch gpg-agent
fi

# export SOPS_AGE_KEY_FILE=$HOME/.sops/key.txt

source ~/.aliases
