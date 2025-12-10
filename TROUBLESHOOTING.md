# Troubleshooting Guide

## Dolo Import Hangs

**Symptom:** `from dolo import yaml_import` hangs indefinitely without error.

**Most Likely Cause:** Numba JIT compilation issue on the remote machine.

### Quick Fix - Disable Numba JIT

```bash
export NUMBA_DISABLE_JIT=1
python -c "from dolo import yaml_import; print('Works!')"
```

If this works, add it to your environment permanently:

```bash
echo 'export NUMBA_DISABLE_JIT=1' >> ~/.bashrc
source ~/.bashrc
```

Or add it to your script/notebook:
```python
import os
os.environ['NUMBA_DISABLE_JIT'] = '1'
from dolo import yaml_import
```

### Debug the Issue

Run the debug script to identify the problem:

```bash
./DEBUG.sh
```

This will test:
1. Python version
2. Package versions
3. Basic imports
4. Numba import
5. Numba JIT compilation (likely culprit)
6. Dolo import

### Common Causes

1. **Threading issues on remote server**
   - Some HPC systems have restricted threading
   - Solution: `export NUMBA_NUM_THREADS=1`

2. **Missing CPU features**
   - Numba tries to use CPU-specific optimizations
   - Solution: `export NUMBA_DISABLE_JIT=1`

3. **Shared filesystem cache issues**
   - Numba cache on network filesystem
   - Solution: `export NUMBA_CACHE_DIR=/tmp/numba_cache`

4. **Fork vs spawn multiprocessing**
   - Default multiprocessing method incompatible
   - Solution: Set fork method before imports

### Full Workaround Environment

If you continue to have issues, set these environment variables:

```bash
export NUMBA_DISABLE_JIT=1
export NUMBA_NUM_THREADS=1
export NUMBA_CACHE_DIR=/tmp/numba_cache
```

### Performance Impact

Disabling JIT (`NUMBA_DISABLE_JIT=1`) will make numba-compiled code slower, but:
- ✅ Everything will still work
- ✅ For this project, the performance difference is minimal
- ✅ Dolo's main computations don't heavily rely on numba JIT

### Test After Fixing

```bash
python -c "from dolo import yaml_import; print('✅ Dolo works!')"
python -c "from Qmod import Qmod; m = Qmod(); m.solve(); print('✅ Qmod works!')"
```

## Other Common Issues

### "uv: command not found"

Install uv:
```bash
curl -LsSf https://astral.sh/uv/install.sh | sh
source ~/.bashrc  # or restart terminal
```

### "Python 3.10 not found"

Install Python 3.10 first:

**Ubuntu/Debian:**
```bash
sudo apt update
sudo apt install python3.10 python3.10-venv python3.10-dev
```

**RHEL/CentOS:**
```bash
sudo yum install python3.10 python3.10-devel
```

**macOS:**
```bash
brew install python@3.10
```

### Package Version Conflicts

If you see version conflict errors, make sure you're using the INSTALL.sh script, which handles the tricky dolo installation.

### Notebooks Don't Start

Make sure you activated the virtual environment:
```bash
source .venv/bin/activate
jupyter notebook Examples/
```

## Still Having Issues?

1. Check Python version: `python --version` (should be 3.8-3.10)
2. Check you're in the venv: `which python` (should show `.venv`)
3. Run the debug script: `./DEBUG.sh`
4. Try the numba workarounds above
5. Check for system-specific issues (HPC, containers, etc.)


