# shell/exports.sh
# Общие переменные и алиасы для Bash и Zsh.

# --- Редактор ---
export EDITOR='nvim'
export VISUAL='nvim'

# --- Инструменты ---
export BAT_THEME="Dracula"
export MANPAGER="sh -c 'col -bx | bat -l man -p'"
export MANROFFOPT="-c"

# --- Локаль ---
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# --- PATH ---
export PATH="$HOME/.local/bin:$HOME/.cargo/bin:$PATH"

# --- Алиасы (без конфликта с функциями y() и br()) ---
alias ls='eza --icons --group-directories-first'
alias ll='eza -l --icons --group-directories-first'
alias la='eza -la --icons --group-directories-first'
alias lt='eza --tree --level=2 --icons'
alias lg='lazygit'

# --- Docker ---
alias dps='docker ps --format "table {{.Names}}\t{{.Status}}\t{{.Ports}}"'
alias dlog='docker logs -f'

# --- Kubernetes ---
alias k='kubectl'
alias kgp='kubectl get pods'
alias kgs='kubectl get svc'
alias kgn='kubectl get nodes'
alias kga='kubectl get all'
alias kdp='kubectl describe pod'
alias k9='k9s'