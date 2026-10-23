На ПК с Windows откройте PowerShell от имени администратора:

powershell
git clone https://github.com/fedorovigord/my-environment.git
cd my-environment
.\bootstrap\bootstrap.ps1
В Windows запустите Ubuntu (WSL), выполните:

bash
git clone https://github.com/fedorovigord/my-environment.git
cd my-environment
chmod +x bootstrap/bootstrap.sh
./bootstrap/bootstrap.sh
Перезапустите терминалы. При первом запуске nvim подождите пару минут, пока LazyVim скачает все плагины и Mason установит LSP-серверы.

