# If ~/.path exists, source it first so PATH is set before any feature testing
[ -r ~/.path ] && source ~/.path

if [ -d ~/.bash/functions ]; then
  for function in ~/.bash/functions/*; do
    [ -f "$function" ] && source "$function"
  done
  unset function
fi

_load_settings() {
  _dir="$1"
  if [ -d "$_dir" ]; then
    for config in "$_dir"/*.bash; do
      [ -f "$config" ] && source "$config"
    done
  fi
  unset _dir config
}

# Load all .bash files in ~/.bash/config as dotfiles
_load_settings ~/.bash/config

[ -r ~/.aliases ] && source ~/.aliases
