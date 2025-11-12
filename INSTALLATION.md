# Installation Guide for Q-Investment

## Quick Installation

**Requirements:** 
- Python 3.8, 3.9, or 3.10 (NOT 3.11 or 3.12)
- [uv](https://docs.astral.sh/uv/) package manager

### Install uv

If you don't have uv installed:

```bash
curl -LsSf https://astral.sh/uv/install.sh | sh
```

Or on macOS with Homebrew:

```bash
brew install uv
```

### Install Q-Investment

```bash
git clone https://github.com/llorracc/Q-Investment.git
cd Q-Investment
./INSTALL.sh
source .venv/bin/activate
```

The script will:
1. Create a virtual environment with Python 3.10
2. Install dolo (bypassing its conflicting metadata)
3. Install Q-Investment with all dependencies

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
3. Try the manual installation steps above
4. Check for error messages about missing system dependencies
