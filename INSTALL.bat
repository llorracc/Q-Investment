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

REM Activate the virtual environment
call .venv\Scripts\activate.bat

REM Install dolo without dependency checking (it has conflicting metadata)
REM Dolo's metadata declares quantecon<0.5, but Python 3.10 requires quantecon>=0.10
REM We bypass this by installing with --no-deps, then install compatible versions
echo.
echo Installing dolo (bypassing conflicting metadata)...
uv pip install --no-deps dolo==0.4.9.12
if %errorlevel% neq 0 (
    echo Error: Failed to install dolo.
    exit /b 1
)

REM Verify dolo is installed
python -c "import dolo" >nul 2>&1
if %errorlevel% neq 0 (
    echo Error: dolo installation verification failed.
    exit /b 1
)
echo [OK] dolo installed successfully

REM Install dolo's dependencies (from pyproject.toml [dolo] section)
echo.
echo Installing dolo dependencies...
uv pip install -e ".[dolo,dev]"
if %errorlevel% neq 0 (
    echo Error: Failed to install dolo dependencies.
    exit /b 1
)

REM Verify dolo can be imported with all dependencies
echo.
echo Verifying dolo installation with dependencies...
python -c "from dolo import *; import dolo.algos.perfect_foresight as pf; import dolo.algos.value_iteration as vi; print('[OK] dolo imports successful')" >nul 2>&1
if %errorlevel% neq 0 (
    echo Warning: dolo imports with warnings (this may be normal)
)

REM Verify Qmod can be imported
echo.
echo Verifying Qmod installation...
python -c "from Qmod import Qmod; print('[OK] Qmod imports successful')" >nul 2>&1
if %errorlevel% neq 0 (
    echo Error: Qmod import failed.
    exit /b 1
)

REM Final verification
echo.
echo Running final installation test...
python -c "from Qmod import Qmod; from dolo import yaml_import; print('[OK] All imports successful')" >nul 2>&1
if %errorlevel% equ 0 (
    echo.
    echo ==================================
    echo [OK] Installation complete and verified!
    echo ==================================
) else (
    echo.
    echo Warning: Installation complete but verification had warnings
    echo    This may be normal - try running the test command manually
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


