# .zshrc for 5.7.1
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

export GPG_TTY="$(tty)"
export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
gpgconf --launch gpg-agent

export SOPS_AGE_KEY_FILE=$HOME/.sops/key.txt

source ~/.aliases
