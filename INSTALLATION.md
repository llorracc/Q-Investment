# Installation Guide for Q-Investment

**📑 Looking for something else?** See **[INDEX.md](INDEX.md)** for complete repository navigation.

## Quick Installation

**Requirements:** 
- [uv](https://docs.astral.sh/uv/) package manager
- Internet connection (for automatic Python download if needed)

**Note:** You don't need to pre-install Python! The install script will automatically download Python 3.10 if it's not found on your system. The virtual environment will use Python 3.10 (which is compatible with Python 3.8-3.10 requirements).

### Install uv

**Linux/macOS:**
```bash
curl -LsSf https://astral.sh/uv/install.sh | sh
```

**macOS (Homebrew):**
```bash
brew install uv
```

**Windows (PowerShell):**
```powershell
irm https://astral.sh/uv/install.ps1 | iex
```

**Windows (using Python):**
```cmd
pip install uv
```

### Install Q-Investment

**Linux/macOS:**
```bash
git clone https://github.com/llorracc/Q-Investment.git
cd Q-Investment
./INSTALL.sh
source .venv/bin/activate
```

**Windows (PowerShell):**
```powershell
git clone https://github.com/llorracc/Q-Investment.git
cd Q-Investment
.\INSTALL.ps1
.venv\Scripts\Activate.ps1
```

**Windows (Command Prompt):**
```cmd
git clone https://github.com/llorracc/Q-Investment.git
cd Q-Investment
INSTALL.bat
.venv\Scripts\activate
```

The script will:
1. **Download and install Python 3.10** into uv's managed Python directory (ensures isolation and reproducibility)
2. Create a virtual environment using the uv-managed Python 3.10 (not system Python)
3. Install dolo (bypassing its conflicting metadata)
4. Install Q-Investment with all dependencies

**Important:** The script always installs Python 3.10 via uv, even if you already have Python 3.10 elsewhere on your system. This ensures:
- **Reproducibility** - Same Python version for all users
- **Isolation** - Virtual environment doesn't depend on system Python
- **Consistency** - Works the same way on all systems

You don't need to manually install Python first - the script handles everything!

### Verify Installation

```bash
python -c "from Qmod import Qmod; from dolo import yaml_import; print('✅ Works!')"
```

### Run Notebooks

```bash
jupyter notebook Examples/
```

### Run Tests

```bash
pytest tests/
```

## Troubleshooting

### "uv: command not found"

Install uv first (see above).

### "Python 3.10 not found"

The script requires Python 3.10. Install it:

**macOS (using Homebrew):**
```bash
brew install python@3.10
```

**Ubuntu/Debian:**
```bash
sudo apt update
sudo apt install python3.10 python3.10-venv
```

**Using pyenv:**
```bash
pyenv install 3.10.13
pyenv local 3.10.13
```

### "Package requires Python >=3.8,<3.11"

You're using Python 3.11 or 3.12. This package requires Python 3.10 or earlier due to old dependencies (numba, numpy versions needed for Dolo).

### Manual Installation

If the script doesn't work, run the commands manually:

```bash
cd Q-Investment
uv venv --python 3.10
uv pip install --no-deps dolo==0.4.9.12
uv pip install -e ".[dolo,dev]"
source .venv/bin/activate
```

### Notebooks fail with "No module named 'dolo'"

Make sure you installed with the script or included `.[dolo]` in the installation.

## Why Python 3.10?

This project depends on:
- `numba 0.56.4` - released before Python 3.11 existed
- `numpy <1.25` - required for numba compatibility
- `dolo 0.4.9.12` - unmaintained package from 2020

These packages don't support Python 3.11+.

## Why the Two-Step Dolo Install?

Dolo's package metadata declares `quantecon<0.5` but Python 3.10 requires `quantecon>=0.10` (the `gcd` function moved from `fractions` to `math`). Installing dolo with `--no-deps` bypasses this metadata conflict. The newer versions work fine at runtime.

## Getting Help

If you encounter issues:
1. Check that you're using Python 3.8-3.10
2. Verify uv is installed: `uv --version`
3. **If dolo import hangs:** See [TROUBLESHOOTING.md](TROUBLESHOOTING.md)
4. Try the manual installation steps above
5. Run `./DEBUG.sh` to diagnose the problem
