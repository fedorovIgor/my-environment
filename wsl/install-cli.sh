#!/usr/bin/env bash
# wsl/install-cli.sh
set -e

echo "=== Обновление системы и базовые пакеты ==="
sudo apt update && sudo apt upgrade -y
sudo apt install -y \
    git curl wget unzip zip build-essential \
    python3 python3-pip pipx \
    golang openjdk-21-jdk maven gradle \
    docker.io docker-compose-v2 \
    gcc cmake gdb gdb-multiarch gcc-arm-none-eabi \
    qtbase5-dev qtcreator \
    postgresql-client mysql-client sqlite3 \
    ripgrep fd-find bat fzf tmux htop \
    jq yq restic broot mmv fpc lazarus \
    zsh

# Симлинки (не трогаем системные утилиты)
mkdir -p ~/.local/bin
ln -sf /usr/bin/batcat ~/.local/bin/bat
ln -sf /usr/bin/fdfind ~/.local/bin/fd

echo "=== uv, Rust, Node.js ==="
curl -LsSf https://astral.sh/uv/install.sh | sh
if ! command -v rustc &>/dev/null; then curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y; source "$HOME/.cargo/env"; fi
if ! command -v node &>/dev/null; then curl -fsSL https://deb.nodesource.com/setup_lts.x | sudo -E bash -; sudo apt install -y nodejs; fi
if command -v npm &>/dev/null; then npm install -g @angular/cli; fi

echo "=== Starship, Zoxide, Atuin, Delta ==="
curl -sS https://starship.rs/install.sh | sh -s -- -y
curl -sS https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | bash
curl --proto '=https' --tlsv1.2 -LsSf https://setup.atuin.sh | sh
cargo install git-delta 2>/dev/null || echo "Пропущено: delta"

echo "=== Yazi, Lazygit, K8s tools ==="
wget -qO yazi.zip https://github.com/sxyazi/yazi/releases/latest/download/yazi-x86_64-unknown-linux-gnu.zip
unzip -q yazi.zip -d yazi-temp && sudo mv yazi-temp/yazi-x86_64-unknown-linux-gnu/yazi /usr/local/bin/ && rm -rf yazi.zip yazi-temp

LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
tar xf lazygit.tar.gz lazygit && sudo install lazygit /usr/local/bin && rm lazygit.tar.gz lazygit

curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl && rm kubectl

curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3
chmod 700 get_helm.sh && ./get_helm.sh && rm get_helm.sh

curl -Lo ./kind https://kind.sigs.k8s.io/dl/v0.22.0/kind-linux-amd64
chmod +x ./kind && sudo mv ./kind /usr/local/bin/kind

wget -qO k9s.tar.gz https://github.com/derailed/k9s/releases/latest/download/k9s_Linux_amd64.tar.gz
tar -xzf k9s.tar.gz k9s && sudo mv k9s /usr/local/bin/ && rm k9s.tar.gz