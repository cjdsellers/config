# Setup path
fpath+=($HOME/.zsh/pure)

export TERM=tmux-256color
export EDITOR=nvim

# History in cache directory
HISTSIZE=10000000
SAVEHIST=10000000
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
alias venv="source .venv/bin/activate"
alias update-ai-tools='claude update && npm install -g @openai/codex && codex --version'
alias claude="/home/chris/.claude/local/claude"

# Clear all panes in the current tmux window
clear_all() {
  if [[ -z "$TMUX" ]]; then
    echo "Not inside tmux."
    return 1
  fi
  tmux list-panes -F "#{pane_id}" | while read -r p; do
    tmux send-keys -t "$p" C-l
  done
}
alias clear-all='clear_all'

# Python
alias python='python3'
alias pyenv-setup='
  if [[ -f .venv/bin/python3 ]]; then
    PYVER=$(.venv/bin/python3 --version | awk "{print \$2}" | cut -d. -f1,2)
    PYPATH=$(find ~/.local/share/uv/python -maxdepth 1 -type d -name "cpython-${PYVER}.*-linux-x86_64-gnu" 2>/dev/null | head -n1)
    if [[ -n "$PYPATH" ]]; then
      export LD_LIBRARY_PATH="${PYPATH}/lib"
      export PYO3_PYTHON=$(pwd)/.venv/bin/python3
      echo "✓ Set up Python ${PYVER} environment"
    else
      echo "✗ Could not find uv Python installation for version ${PYVER}"
    fi
  else
    echo "✗ No .venv/bin/python3 found in current directory"
  fi
'

export PYTHON_CONFIGURE_OPTS="--enable-shared"

### Commands ###

# nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
. "$HOME/.cargo/env"

# Nautilus
export LD_LIBRARY_PATH="nautilus_trader/core/rust/libs"

export PATH="$HOME/.cargo/bin:$PATH:$HOME/.local/share/bob/nvim-bin"
