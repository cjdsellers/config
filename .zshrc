# Setup path
fpath+=($HOME/.zsh/pure)

export TERM=tmux-256color
export EDITOR=nvim

# History in cache directory
HISTSIZE=20000
SAVEHIST=20000
HISTFILE=~/.cache/zshhistory
setopt appendhistory

# Basic auto/tab complete
autoload -U compinit; compinit

# Pure
autoload -U promptinit; promptinit
zstyle ':prompt:pure:prompt:*' color green
prompt pure

zstyle ':completion:*' menu select
zmodload zsh/complist
_comp_options+=(globdots)

# Aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'

### Commands ###

# pyenv
export PYENV_ROOT="$HOME/.pyenv"
export PYTHON_CONFIGURE_OPTS="--enable-shared"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

# nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
. "$HOME/.cargo/env"

# Nautilus
export LD_LIBRARY_PATH="natilus_trader/core/rust/libs"

export PATH="$PATH:$HOME/.local/share/bob/nvim-bin:$HOME/arcanist/bin"
