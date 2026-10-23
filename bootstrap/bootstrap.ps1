# bootstrap/bootstrap.ps1
$ErrorActionPreference = 'Stop'
$repoRoot = Split-Path -Parent $PSScriptRoot

Write-Host "=== Запуск Bootstrap для Windows ===" -ForegroundColor Green

Write-Host "`n--- Шаг 1: Установка CLI-инструментов (Scoop) ---" -ForegroundColor Cyan
& "$repoRoot\windows\install-cli.ps1"

Write-Host "`n--- Шаг 2: Развертывание конфигураций ---" -ForegroundColor Cyan
$configDir = Join-Path $HOME ".config"
if (-not (Test-Path $configDir)) { New-Item -ItemType Directory -Path $configDir -Force | Out-Null }

# .bashrc
Copy-Item "$repoRoot\windows\bashrc" (Join-Path $HOME ".bashrc") -Force
Write-Host "  -> .bashrc развернут" -ForegroundColor Green

# Общие exports
$exportsTarget = Join-Path $configDir "shell"
if (-not (Test-Path $exportsTarget)) { New-Item -ItemType Directory -Path $exportsTarget -Force | Out-Null }
Copy-Item "$repoRoot\shell\exports.sh" (Join-Path $exportsTarget "exports.sh") -Force
Write-Host "  -> Общие exports развернуты" -ForegroundColor Green

# Конфиг Neovim
$nvimTarget = Join-Path $configDir "nvim"
if (-not (Test-Path $nvimTarget)) { New-Item -ItemType Directory -Path $nvimTarget -Force | Out-Null }
Copy-Item "$repoRoot\nvim\*" $nvimTarget -Recurse -Force
Write-Host "  -> Конфиг Neovim развернут" -ForegroundColor Green

Write-Host "`n=== Bootstrap для Windows завершен! ===" -ForegroundColor Green