# Installation Guide for Q-Investment

This guide covers how to install and set up the Q-Investment package using modern Python tools.

## Prerequisites

- **Python 3.8, 3.9, or 3.10** (not 3.11 or 3.12 - see note below)
- `uv` (recommended) or `pip`

### Python Version Note

This project requires **Python 3.10 or earlier** due to dependencies on older packages:
- `numba 0.56.4` (needed for Dolo) was released before Python 3.11
- `numpy <1.25` is required for numba compatibility

**Recommended:** Use Python 3.10 for best compatibility.

## Installing uv (Recommended)

`uv` is a fast Python package installer and resolver. Install it with:

```bash
curl -LsSf https://astral.sh/uv/install.sh | sh
```

Or on macOS with Homebrew:

```bash
brew install uv
```

## Installation Options

### Option 1: Using uv (Recommended)

#### Quick Start - Everything (Qmod + Dolo + Dev Tools)

```bash
# Clone the repository
git clone https://github.com/llorracc/Q-Investment.git
cd Q-Investment

# Create a virtual environment with Python 3.10
# Option 1: Let uv find Python 3.10
uv venv --python 3.10

# Option 2: Specify exact Python path
# uv venv --python /path/to/python3.10

# Install dolo first (bypassing its conflicting metadata)
uv pip install --no-deps dolo==0.4.9.12

# Install everything else
uv pip install -e ".[dolo,dev]"
```

**Note:** If you get Python 3.12 by default, explicitly specify `--python 3.10` when creating the venv.

#### Basic Installation (Qmod only)

```bash
# Create a virtual environment
uv venv

# Install the package in editable mode
uv pip install -e .
```

#### With Development Tools Only

To include pytest, jupyter, and other development tools (without Dolo):

```bash
uv pip install -e ".[dev]"
```

#### With Dolo Support

To include Dolo support (required for 4 out of 5 example notebooks):

```bash
# Install dolo without checking its (conflicting) dependencies
uv pip install --no-deps dolo==0.4.9.12

# Then install the working dependencies
uv pip install -e ".[dolo]"
```

**Why two steps?** Dolo's package metadata declares dependency versions (e.g., `quantecon<0.5`) that conflict with Python 3.10 requirements, but the newer versions we install actually work fine at runtime.

### Option 2: Using pip

```bash
# Clone the repository
git clone https://github.com/llorracc/Q-Investment.git
cd Q-Investment

# Create a virtual environment
python -m venv .venv
source .venv/bin/activate  # On Windows: .venv\Scripts\activate

# Install the package
pip install -e .

# Or with dev tools
pip install -e ".[dev]"
```

## Verifying Installation

### Test Qmod Installation

```python
from Qmod import Qmod

# Create a model instance
model = Qmod()
print(f"✅ Qmod imported successfully! Beta={model.beta}, Alpha={model.alpha}")

# Solve the model
model.solve()
print(f"✅ Model solved! Steady state capital: {model.kSS:.4f}")
```

### Test Dolo Installation (if installed)

```python
from dolo import yaml_import

# Load the Q-model
model = yaml_import("Dolo/Q-model.yaml")
print("✅ Dolo imported successfully!")
```

### Run Tests

```bash
# Run the test suite
pytest tests/

# Run with coverage
pytest tests/ --cov=Qmod --cov-report=html
```

### Run Notebooks

```bash
# Start Jupyter
jupyter notebook

# Navigate to Examples/ folder and open any notebook
# Start with: Qmod-basic-features.ipynb
```

## Package Structure

```
Q-Investment/
├── Qmod/                  # Main package
│   ├── __init__.py
│   └── q-investment.py    # Qmod class implementation
├── Dolo/                  # Dolo model definition
│   └── Q-model.yaml
├── Examples/              # Jupyter notebooks
├── tests/                 # Test suite
├── pyproject.toml         # Package configuration
└── README.md
```

## Common Issues

### Issue: `ModuleNotFoundError: No module named 'Qmod'`

**Solution**: Make sure you've installed the package with `-e` flag:
```bash
uv pip install -e .
```

### Issue: Dolo import fails

**Solution**: Install the Dolo dependencies:
```bash
uv pip install -e ".[dolo]"
```

The package includes tested versions that are known to work together.

### Issue: Tests fail with numerical warnings

**Solution**: Some warnings during model solving are expected and are handled gracefully by the code. As long as tests pass, the warnings can be ignored.

## Updating the Package

If you've made changes to the code:

```bash
# No need to reinstall with -e flag
# Just import the updated module

# To run tests after changes:
pytest tests/
```

## Uninstalling

```bash
uv pip uninstall q-investment
# or
pip uninstall q-investment
```

## Additional Resources

- [Project Repository](https://github.com/llorracc/Q-Investment)
- [Lecture Notes](http://www.econ2.jhu.edu/people/ccarroll/public/lecturenotes/Investment/qModel/)
- [Binder (Interactive Notebooks)](https://mybinder.org/v2/gh/llorracc/Q-Investment/master)

## Development Workflow

For contributors:

```bash
# 1. Clone and install in dev mode
git clone https://github.com/llorracc/Q-Investment.git
cd Q-Investment
uv venv
uv pip install -e ".[dev]"

# 2. Make changes to the code

# 3. Run tests
pytest tests/

# 4. Run notebooks to verify
jupyter notebook Examples/

# 5. Commit and push
git add .
git commit -m "Your commit message"
git push
```

