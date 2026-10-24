#!/usr/bin/env bash
# bootstrap/bootstrap.sh
set -e

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
echo "=== Запуск Bootstrap ==="

# Определяем, WSL это или обычный Linux
if grep -qi microsoft /proc/version; then
    IS_WSL=true
    echo "Обнаружен WSL"
else
    IS_WSL=false
    echo "Обнаружен чистый Linux"
fi

echo -e "\n--- Шаг 1: Установка CLI-инструментов ---"
bash "$REPO_ROOT/linux/install-cli.sh" "$IS_WSL"

echo -e "\n--- Шаг 2: Настройка Zsh и Oh My Zsh ---"
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
    sudo chsh -s $(which zsh) $USER
fi

ZSH_CUSTOM=${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}
git clone https://github.com/zsh-users/zsh-autosuggestions $ZSH_CUSTOM/plugins/zsh-autosuggestions 2>/dev/null || true
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting 2>/dev/null || true
git clone https://github.com/zsh-users/zsh-completions $ZSH_CUSTOM/plugins/zsh-completions 2>/dev/null || true

echo -e "\n--- Шаг 3: Развертывание конфигураций ---"
mkdir -p "$HOME/.config/shell" "$HOME/.config/nvim"

cp "$REPO_ROOT/linux/zshrc" "$HOME/.zshrc"
cp "$REPO_ROOT/shell/exports.sh" "$HOME/.config/shell/exports.sh"
cp -r "$REPO_ROOT/nvim/"* "$HOME/.config/nvim/"

echo -e "\n=== Bootstrap завершен! ==="
echo "Выполните 'exec zsh', чтобы применить изменения."