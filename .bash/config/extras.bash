# Case-insensitive globbing (used in pathname expansion)
shopt -s nocaseglob;

# Append to the Bash history file, rather than overwriting it
shopt -s histappend;

# Autocorrect typos in path names when using `cd`
shopt -s cdspell;

# Enable some Bash 4 features when possible:
# * `autocd`, e.g. `**/qux` will enter `./foo/bar/baz/qux`
# * Recursive globbing, e.g. `echo **/*.txt`
for option in autocd globstar; do
	shopt -s "$option" 2> /dev/null;
done;

# Add tab completion for many Bash commands
# bash-completion 2 needs bash 4+, which macOS only has via Homebrew
if [ -n "$HOMEBREW_PREFIX" ] && [ "${BASH_VERSINFO[0]}" -ge 4 ] \
	&& [ -r "$HOMEBREW_PREFIX/etc/profile.d/bash_completion.sh" ]; then
	source "$HOMEBREW_PREFIX/etc/profile.d/bash_completion.sh";
elif [ -r /usr/share/bash-completion/bash_completion ]; then
	source /usr/share/bash-completion/bash_completion;
elif [ -f /etc/bash_completion ]; then
	source /etc/bash_completion;
fi;

# Enable tab completion for `g` by marking it as an alias for `git`
if type _git &> /dev/null; then
  complete -o default -o nospace -F _git g;
fi;

# Add tab completion for SSH hostnames based on ~/.ssh/config, ignoring wildcards
[ -e "$HOME/.ssh/config" ] && complete -o "default" -o "nospace" -W "$(grep "^Host" ~/.ssh/config | grep -v "[?*]" | cut -d " " -f2- | tr ' ' '\n')" scp sftp ssh;

# Add tab completion for `defaults read|write NSGlobalDomain`
# You could just use `-g` instead, but I like being explicit
if [ "$(uname)" = "Darwin" ]; then
	complete -W "NSGlobalDomain" defaults;
fi;
