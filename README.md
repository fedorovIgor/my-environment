# My Environment

Персональная среда разработки, разворачиваемая одной командой. Поддерживает Windows (через Scoop), WSL и чистый Linux (Ubuntu/Debian).

## Установка на Windows
Откройте PowerShell от имени администратора:
    git clone https://github.com/fedorovigord/my-environment.git
    cd my-environment
    .\bootstrap\bootstrap.ps1

## Установка на Linux / WSL
Откройте терминал:
    git clone https://github.com/fedorovigord/my-environment.git
    cd my-environment
    chmod +x bootstrap/bootstrap.sh
    ./bootstrap/bootstrap.sh

## Post-Install
1. Перезапустите терминалы (в Linux выполните `exec zsh`).
2. При первом запуске `nvim` подождите пару минут — LazyVim скачает плагины, а Mason установит LSP-серверы.
3. Для проверки целостности запустите `bash scripts/doctor.sh`.