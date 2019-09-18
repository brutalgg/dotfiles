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

source ~/.aliases

