# .zshrc for 5.7.1
fpath+=("$HOME/.zsh/pure")
autoload -U promptinit; promptinit
autoload -Uz compinit && compinit -i
prompt pure
source ~/.aliases
