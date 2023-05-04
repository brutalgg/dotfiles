# Add `~/bin` to the `$PATH`
# export PATH="$HOME/bin:$PATH";

if [ -d ~/.bash/functions ]; then
  for function in $(find ~/.bash/functions -type f -print); do
    source "$function";
  done
fi

_load_settings() {
  _dir="$1"
  if [ -d "$_dir" ]; then
    for config in $(find "$_dir" -name "*.bash" -print); do
      source $config
    done
  fi
}

# Load all .bash files in ~/.bash/config as dotfiles
_load_settings ~/.bash/config
