#!/usr/bin/env bash
# linux/install-cli.sh
set -e

IS_WSL=$1
CURL_OPTS="-fL --retry 5 --retry-delay 3 --retry-all-errors -4"

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
    jq restic mmv fpc lazarus \
    zsh

# Симлинки
mkdir -p ~/.local/bin
ln -sf /usr/bin/batcat ~/.local/bin/bat
ln -sf /usr/bin/fdfind ~/.local/bin/fd

# Специфичные для WSL фиксы
if [ "$IS_WSL" = true ]; then
    echo "=== Применение фиксов для WSL (MTU) ==="
    sudo ip link set dev eth0 mtu 1400 || true
fi

echo "=== uv, Rust, Node.js ==="
curl $CURL_OPTS -LsSf https://astral.sh/uv/install.sh | sh
if ! command -v rustc &>/dev/null; then 
    curl $CURL_OPTS -sSf https://sh.rustup.rs | sh -s -- -y
    source "$HOME/.cargo/env"
fi
if ! command -v node &>/dev/null; then 
    curl $CURL_OPTS -fsSL https://deb.nodesource.com/setup_lts.x | sudo -E bash - 
    sudo apt install -y nodejs
fi
if command -v npm &>/dev/null; then
    mkdir -p "$HOME/.local"
    npm config set prefix "$HOME/.local"
    npm install -g @angular/cli neovim tree-sitter-cli
fi

echo "=== yq, broot ==="
sudo curl $CURL_OPTS -o /usr/local/bin/yq https://github.com/mikefarah/yq/releases/latest/download/yq_linux_amd64
sudo chmod +x /usr/local/bin/yq
curl $CURL_OPTS -o broot https://dystroy.org/broot/download/x86_64-linux/broot
chmod +x broot && sudo mv broot /usr/local/bin/broot

echo "=== Starship, Zoxide, Delta ==="
curl $CURL_OPTS -sS https://starship.rs/install.sh | sh -s -- -y
curl $CURL_OPTS -sS https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | bash
cargo install git-delta fd-find 2>/dev/null || echo "Пропущено: delta/fd"

echo "=== Neovim ==="
curl $CURL_OPTS -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz
sudo rm -rf /opt/nvim
sudo tar -C /opt -xzf nvim-linux-x86_64.tar.gz
sudo ln -sf /opt/nvim-linux-x86_64/bin/nvim /usr/local/bin/nvim
rm nvim-linux-x86_64.tar.gz

echo "=== Yazi, Lazygit, K8s tools ==="
curl $CURL_OPTS -o yazi.zip https://github.com/sxyazi/yazi/releases/latest/download/yazi-x86_64-unknown-linux-gnu.zip
unzip -q yazi.zip -d yazi-temp && sudo mv yazi-temp/yazi-x86_64-unknown-linux-gnu/yazi /usr/local/bin/ && rm -rf yazi.zip yazi-temp

LAZYGIT_VERSION=$(curl $CURL_OPTS -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
curl $CURL_OPTS -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
tar xf lazygit.tar.gz lazygit && sudo install lazygit /usr/local/bin && rm lazygit.tar.gz lazygit

curl $CURL_OPTS -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl && rm kubectl

curl $CURL_OPTS -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3
chmod 700 get_helm.sh && ./get_helm.sh && rm get_helm.sh

curl $CURL_OPTS -Lo ./kind https://kind.sigs.k8s.io/dl/v0.22.0/kind-linux-amd64
chmod +x ./kind && sudo mv ./kind /usr/local/bin/kind

curl $CURL_OPTS -Lo k9s.tar.gz https://github.com/derailed/k9s/releases/latest/download/k9s_Linux_amd64.tar.gz
tar -xzf k9s.tar.gz k9s && sudo mv k9s /usr/local/bin/ && rm k9s.tar.gz

echo "=== Atuin (тихая установка) ==="
ATUIN_VERSION=$(curl $CURL_OPTS -s "https://api.github.com/repos/atuinsh/atuin/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
curl $CURL_OPTS -Lo atuin.tar.gz "https://github.com/atuinsh/atuin/releases/download/v${ATUIN_VERSION}/atuin-x86_64-unknown-linux-musl.tar.gz"
tar -xzf atuin.tar.gz
sudo mv atuin-x86_64-unknown-linux-musl/atuin /usr/local/bin/
rm -rf atuin.tar.gz atuin-x86_64-unknown-linux-musl

echo "Установка завершена!"