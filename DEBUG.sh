#!/bin/bash
# Debug script for dolo import hanging

echo "=================================="
echo "Debugging Dolo Import"
echo "=================================="
echo ""

echo "1. Checking Python version..."
python --version
echo ""

echo "2. Checking installed packages..."
python -c "import sys; print(f'Python: {sys.version}')"
python -c "import numpy; print(f'numpy: {numpy.__version__}')"
python -c "import numba; print(f'numba: {numba.__version__}')"
python -c "import pandas; print(f'pandas: {pandas.__version__}')"
echo ""

echo "3. Testing basic imports (should be fast)..."
python -c "import numpy; print('✅ numpy')"
python -c "import pandas; print('✅ pandas')"
python -c "import scipy; print('✅ scipy')"
echo ""

echo "4. Testing numba (this might hang if there's a problem)..."
timeout 10 python -c "import numba; print('✅ numba imports')" || echo "❌ numba import timed out"
echo ""

echo "5. Testing numba JIT compilation (the likely culprit)..."
timeout 10 python << 'PYEOF'
import numba
@numba.jit
def test_func(x):
    return x + 1
result = test_func(5)
print(f'✅ numba JIT works: test_func(5) = {result}')
PYEOF
if [ $? -ne 0 ]; then
    echo "❌ numba JIT compilation failed or timed out"
    echo ""
    echo "This is likely your problem. Solutions:"
    echo "  1. Set NUMBA_DISABLE_JIT=1 to disable JIT"
    echo "  2. Check for threading issues"
    echo "  3. Verify CPU supports required instructions"
fi
echo ""

echo "6. Testing dolo import with timeout..."
timeout 30 python -c "from dolo import yaml_import; print('✅ dolo imports')" || echo "❌ dolo import timed out or failed"
echo ""

echo "=================================="
echo "Debug complete"
echo "=================================="

