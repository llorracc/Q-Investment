#!/bin/bash
# Quick script to launch Jupyter in your virtual environment

cd "$(dirname "$0")"
source .venv/bin/activate

echo "🚀 Starting Jupyter Notebook..."
echo "   Notebooks will open in your browser"
echo "   Press Ctrl+C to stop"
echo ""

# Launch Jupyter notebook
jupyter notebook Examples/

