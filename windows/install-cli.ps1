# windows/install-cli.ps1
$ErrorActionPreference = 'Stop'

if (-not (Get-Command scoop -ErrorAction SilentlyContinue)) {
    Invoke-RestMethod -Uri https://get.scoop.sh | Invoke-Expression
}

scoop bucket add main 2>$null
scoop bucket add extras 2>$null
scoop bucket add java 2>$null

$core = @(
    # Рантаймы
    "python", "uv", "nodejs-lts", "go", "rustup", "openjdk", "make",
    # C/C++ и Embedded
    "gcc", "cmake", "gdb", "gcc-arm-none-eabi", "fpc",
    # DevOps
    "docker", "kubectl", "helm", "kind", "k9s", "lazygit", "gh",
    # Утилиты
    "git", "ripgrep", "fd", "delta", "jq", "yq", "sd", "restic",
    "starship", "zoxide", "fzf", "atuin", "yazi", "broot", "brename", "win32yank",
    "sysinternals"
)

foreach ($pkg in $core) {
    Write-Host "→ Установка: $pkg" -ForegroundColor Cyan
    scoop install $pkg
}

if (-not (Get-Command rustc -ErrorAction SilentlyContinue)) { rustup default stable }
if (Get-Command npm -ErrorAction SilentlyContinue) { npm install -g @angular/cli }