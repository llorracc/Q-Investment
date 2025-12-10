@echo off
REM Installation script for Q-Investment on Windows
REM Requires: Python 3.8-3.10 and uv

echo ==================================
echo Q-Investment Installation (Windows)
echo ==================================
echo.

REM Check if uv is installed
where uv >nul 2>nul
if %errorlevel% neq 0 (
    echo Error: uv is not installed.
    echo Install it with: powershell -c "irm https://astral.sh/uv/install.ps1 | iex"
    exit /b 1
)

REM Ensure Python 3.10 is installed in uv's managed Python directory
REM This ensures reproducible, isolated installations regardless of system Python
echo Ensuring Python 3.10 is installed (uv-managed)...
uv python install 3.10
if %errorlevel% neq 0 (
    echo Error: Failed to install Python 3.10.
    echo Check your internet connection.
    exit /b 1
)

REM Create virtual environment with uv-managed Python 3.10
REM --managed-python forces use of uv's managed Python (not system Python)
echo Creating virtual environment with Python 3.10...
uv venv --python 3.10 --managed-python
if %errorlevel% neq 0 (
    echo Error: Failed to create virtual environment.
    exit /b 1
)

REM Install dolo without dependency checking (it has conflicting metadata)
echo Installing dolo (bypassing conflicting metadata)...
uv pip install --no-deps dolo==0.4.9.12
if %errorlevel% neq 0 (
    echo Error: Failed to install dolo.
    exit /b 1
)

REM Install the package with all dependencies
echo Installing Q-Investment with all dependencies...
uv pip install -e ".[dolo,dev]"
if %errorlevel% neq 0 (
    echo Error: Failed to install Q-Investment.
    exit /b 1
)

echo.
echo ==================================
echo Installation complete!
echo ==================================
echo.
echo To activate the environment:
echo   .venv\Scripts\activate
echo.
echo To test the installation:
echo   python -c "from Qmod import Qmod; from dolo import yaml_import; print('Works!')"
echo.
echo To run notebooks:
echo   jupyter notebook Examples/
echo.


