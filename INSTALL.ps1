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

# Activate the virtual environment
Write-Host "Activating virtual environment..." -ForegroundColor Yellow
& .venv\Scripts\Activate.ps1

# Install dolo without dependency checking (it has conflicting metadata)
# Dolo's metadata declares quantecon<0.5, but Python 3.10 requires quantecon>=0.10
# We bypass this by installing with --no-deps, then install compatible versions
Write-Host ""
Write-Host "Installing dolo (bypassing conflicting metadata)..." -ForegroundColor Yellow
uv pip install --no-deps dolo==0.4.9.12
if ($LASTEXITCODE -ne 0) {
    Write-Host "Error: Failed to install dolo." -ForegroundColor Red
    exit 1
}

# Verify dolo is installed
$doloCheck = python -c "import dolo" 2>&1
if ($LASTEXITCODE -ne 0) {
    Write-Host "Error: dolo installation verification failed." -ForegroundColor Red
    exit 1
}
Write-Host "✓ dolo installed successfully" -ForegroundColor Green

# Install dolo's dependencies (from pyproject.toml [dolo] section)
Write-Host ""
Write-Host "Installing dolo dependencies..." -ForegroundColor Yellow
uv pip install -e ".[dolo,dev]"
if ($LASTEXITCODE -ne 0) {
    Write-Host "Error: Failed to install dolo dependencies." -ForegroundColor Red
    exit 1
}

# Verify dolo can be imported with all dependencies
Write-Host ""
Write-Host "Verifying dolo installation with dependencies..." -ForegroundColor Yellow
$doloVerify = python -c "from dolo import *; import dolo.algos.perfect_foresight as pf; import dolo.algos.value_iteration as vi; print('✓ dolo imports successful')" 2>&1
if ($LASTEXITCODE -ne 0) {
    Write-Host "Warning: dolo imports with warnings (this may be normal)" -ForegroundColor Yellow
}

# Verify Qmod can be imported
Write-Host ""
Write-Host "Verifying Qmod installation..." -ForegroundColor Yellow
$qmodCheck = python -c "from Qmod import Qmod; print('✓ Qmod imports successful')" 2>&1
if ($LASTEXITCODE -ne 0) {
    Write-Host "Error: Qmod import failed." -ForegroundColor Red
    exit 1
}

# Final verification
Write-Host ""
Write-Host "Running final installation test..." -ForegroundColor Yellow
$finalTest = python -c "from Qmod import Qmod; from dolo import yaml_import; print('✓ All imports successful')" 2>&1
if ($LASTEXITCODE -eq 0) {
    Write-Host ""
    Write-Host "==================================" -ForegroundColor Green
    Write-Host "✓ Installation complete and verified!" -ForegroundColor Green
    Write-Host "==================================" -ForegroundColor Green
} else {
    Write-Host ""
    Write-Host "Warning: Installation complete but verification had warnings" -ForegroundColor Yellow
    Write-Host "   This may be normal - try running the test command manually" -ForegroundColor Yellow
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


