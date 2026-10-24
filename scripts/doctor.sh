#!/usr/bin/env bash
# scripts/doctor.sh
set -e

RED='\033[0;31m'; GREEN='\033[0;32m'; YELLOW='\033[1;33m'; NC='\033[0m'

check_cmd() {
    if command -v "$1" &>/dev/null; then
        echo -e "${GREEN}[OK]${NC} $1 -> $(command -v "$1")"
    else
        echo -e "${RED}[--]${NC} $1 не найден"
    fi
}

check_file() {
    if [ -f "$1" ]; then
        echo -e "${GREEN}[OK]${NC} $1"
    else
        echo -e "${RED}[--]${NC} $1 отсутствует"
    fi
}

echo -e "--- Базовые CLI-утилиты ---"
for cmd in git nvim rg fd eza bat fzf zoxide starship lazygit yazi broot tree-sitter atuin; do check_cmd "$cmd"; done

echo -e "\n--- Языки и компиляторы ---"
for cmd in python3 uv node npm go rustc cargo java mvn gradle gcc cmake gdb; do check_cmd "$cmd"; done

echo -e "\n--- DevOps ---"
for cmd in docker kubectl helm kind k9s; do check_cmd "$cmd"; done

echo -e "\n--- Конфигурационные файлы ---"
for file in "$HOME/.bashrc" "$HOME/.zshrc" "$HOME/.config/nvim/init.lua" "$HOME/.config/nvim/lua/config/options.lua" "$HOME/.config/shell/exports.sh"; do
    check_file "$file"
done