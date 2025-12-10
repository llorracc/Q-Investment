# Installation script for Q-Investment on Windows (PowerShell)
# Requires: Python 3.8-3.10 and uv

Write-Host "==================================" -ForegroundColor Cyan
Write-Host "Q-Investment Installation (Windows)" -ForegroundColor Cyan
Write-Host "==================================" -ForegroundColor Cyan
Write-Host ""

# Check if uv is installed
if (-not (Get-Command uv -ErrorAction SilentlyContinue)) {
    Write-Host "Error: uv is not installed." -ForegroundColor Red
    Write-Host "Install it with: irm https://astral.sh/uv/install.ps1 | iex"
    exit 1
}

# Ensure Python 3.10 is installed in uv's managed Python directory
# This ensures reproducible, isolated installations regardless of system Python
Write-Host "Ensuring Python 3.10 is installed (uv-managed)..." -ForegroundColor Yellow
uv python install 3.10
if ($LASTEXITCODE -ne 0) {
    Write-Host "Error: Failed to install Python 3.10." -ForegroundColor Red
    Write-Host "Check your internet connection." -ForegroundColor Yellow
    exit 1
}

# Create virtual environment with uv-managed Python 3.10
# --managed-python forces use of uv's managed Python (not system Python)
Write-Host "Creating virtual environment with Python 3.10..." -ForegroundColor Yellow
uv venv --python 3.10 --managed-python
if ($LASTEXITCODE -ne 0) {
    Write-Host "Error: Failed to create virtual environment." -ForegroundColor Red
    exit 1
}

# Install dolo without dependency checking (it has conflicting metadata)
Write-Host "Installing dolo (bypassing conflicting metadata)..." -ForegroundColor Yellow
uv pip install --no-deps dolo==0.4.9.12
if ($LASTEXITCODE -ne 0) {
    Write-Host "Error: Failed to install dolo." -ForegroundColor Red
    exit 1
}

# Install the package with all dependencies
Write-Host "Installing Q-Investment with all dependencies..." -ForegroundColor Yellow
uv pip install -e ".[dolo,dev]"
if ($LASTEXITCODE -ne 0) {
    Write-Host "Error: Failed to install Q-Investment." -ForegroundColor Red
    exit 1
}

Write-Host ""
Write-Host "==================================" -ForegroundColor Green
Write-Host "✓ Installation complete!" -ForegroundColor Green
Write-Host "==================================" -ForegroundColor Green
Write-Host ""
Write-Host "To activate the environment:" -ForegroundColor Cyan
Write-Host "  .venv\Scripts\Activate.ps1"
Write-Host ""
Write-Host "To test the installation:" -ForegroundColor Cyan
Write-Host "  python -c `"from Qmod import Qmod; from dolo import yaml_import; print('✓ Works!')`""
Write-Host ""
Write-Host "To run notebooks:" -ForegroundColor Cyan
Write-Host "  jupyter notebook Examples/"
Write-Host ""


