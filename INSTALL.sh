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

# Create virtual environment with Python 3.10
echo "Creating virtual environment with Python 3.10..."
uv venv --python 3.10

# Install dolo without dependency checking (it has conflicting metadata)
echo "Installing dolo (bypassing conflicting metadata)..."
uv pip install --no-deps dolo==0.4.9.12

# Install the package with all dependencies
echo "Installing Q-Investment with all dependencies..."
uv pip install -e ".[dolo,dev]"

echo ""
echo "=================================="
echo "✅ Installation complete!"
echo "=================================="
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

