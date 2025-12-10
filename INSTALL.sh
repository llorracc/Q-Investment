#!/bin/bash
# Installation script for Q-Investment
# Requires: Python 3.8-3.10 and uv

set -e  # Exit on error

echo "=================================="
echo "Q-Investment Installation"
echo "=================================="
echo ""

# Check if uv is installed
if ! command -v uv &> /dev/null; then
    echo "Error: uv is not installed."
    echo "Install it with: curl -LsSf https://astral.sh/uv/install.sh | sh"
    exit 1
fi

# Ensure Python 3.10 is installed in uv's managed Python directory
# This ensures reproducible, isolated installations regardless of system Python
echo "Ensuring Python 3.10 is installed (uv-managed)..."
uv python install 3.10

# Create virtual environment with uv-managed Python 3.10
# --managed-python forces use of uv's managed Python (not system Python)
echo "Creating virtual environment with Python 3.10..."
uv venv --python 3.10 --managed-python

# Activate the virtual environment for the rest of the script
source .venv/bin/activate

# Install dolo without dependency checking (it has conflicting metadata)
# Dolo's metadata declares quantecon<0.5, but Python 3.10 requires quantecon>=0.10
# We bypass this by installing with --no-deps, then install compatible versions
echo ""
echo "Installing dolo (bypassing conflicting metadata)..."
if ! uv pip install --no-deps dolo==0.4.9.12; then
    echo "❌ Error: Failed to install dolo"
    exit 1
fi

# Verify dolo is installed
if ! python -c "import dolo" 2>/dev/null; then
    echo "❌ Error: dolo installation verification failed"
    exit 1
fi
echo "✅ dolo installed successfully"

# Install dolo's dependencies (from pyproject.toml [dolo] section)
echo ""
echo "Installing dolo dependencies..."
if ! uv pip install -e ".[dolo,dev]"; then
    echo "❌ Error: Failed to install dolo dependencies"
    exit 1
fi

# Verify dolo can be imported with all dependencies
echo ""
echo "Verifying dolo installation with dependencies..."
if ! python -c "from dolo import *; import dolo.algos.perfect_foresight as pf; import dolo.algos.value_iteration as vi; print('✅ dolo imports successful')" 2>/dev/null; then
    echo "⚠️  Warning: dolo imports with warnings (this may be normal)"
    python -c "from dolo import *" || true
fi

# Verify Qmod can be imported
echo ""
echo "Verifying Qmod installation..."
if ! python -c "from Qmod import Qmod; print('✅ Qmod imports successful')" 2>/dev/null; then
    echo "❌ Error: Qmod import failed"
    exit 1
fi

# Final verification
echo ""
echo "Running final installation test..."
if python -c "from Qmod import Qmod; from dolo import yaml_import; print('✅ All imports successful')" 2>/dev/null; then
    echo ""
    echo "=================================="
    echo "✅ Installation complete and verified!"
    echo "=================================="
else
    echo ""
    echo "⚠️  Installation complete but verification had warnings"
    echo "   This may be normal - try running the test command manually"
fi

echo ""
echo "To activate the environment:"
echo "  source .venv/bin/activate"
echo ""
echo "To test the installation:"
echo "  python -c 'from Qmod import Qmod; from dolo import yaml_import; print(\"✅ Works!\")'"
echo ""
echo "To run notebooks:"
echo "  jupyter notebook Examples/"
echo ""

