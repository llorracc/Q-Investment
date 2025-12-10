# Q-Investment Repository Index

**Quick navigation guide to find what you need**

---

## 📑 Table of Contents

- [🚀 Getting Started](#-getting-started)
- [📂 Repository Structure](#-repository-structure)
- [📚 Documentation Files](#-documentation-files)
- [💻 Core Code](#-core-code)
- [📓 Examples & Tutorials](#-examples--tutorials)
- [🧪 Testing](#-testing)
- [🔧 Configuration Files](#-configuration-files)
- [📊 Output & Figures](#-output--figures)
- [🎯 How Do I...?](#-how-do-i)
- [🔍 Quick Reference](#-quick-reference)

---

## 🚀 Getting Started

**New to this project?** Start here in order:

1. **[README.md](README.md)** - Project overview and quick installation
2. **[QUICKSTART.md](QUICKSTART.md)** - Step-by-step beginner guide
3. **[INSTALLATION.md](INSTALLATION.md)** - Detailed installation instructions
4. **[Examples/Qmod-basic-features.ipynb](Examples/Qmod-basic-features.ipynb)** - Your first hands-on example

---

## 📂 Repository Structure

```
Q-Investment/
│
├── 📘 Documentation (Start Here)
│   ├── README.md                    # Project overview & quick start
│   ├── QUICKSTART.md                # Beginner's step-by-step guide
│   ├── INSTALLATION.md              # Detailed installation guide
│   ├── TROUBLESHOOTING.md           # Common problems & solutions
│   ├── INDEX.md                     # This file - navigation guide
│   ├── PROPOSED_IMPROVEMENTS.md     # Future enhancements plan
│   ├── IMPROVEMENTS.md              # Code quality improvements made
│   └── CHANGES.md                   # Recent changes log
│
├── 🔧 Installation Scripts
│   ├── INSTALL.sh                   # Linux/macOS installer
│   ├── INSTALL.ps1                  # Windows PowerShell installer
│   ├── INSTALL.bat                  # Windows Command Prompt installer
│   ├── DEBUG.sh                     # Installation diagnostics
│   └── CHECK.sh                     # Pre-installation checks (proposed)
│
├── 💻 Core Code
│   └── Qmod/
│       ├── __init__.py              # Package initialization
│       └── q-investment.py          # Main Qmod class implementation
│
├── 📓 Examples & Tutorials
│   └── Examples/
│       ├── Qmod-basic-features.ipynb              # ⭐ Start here
│       ├── Qmod-basic-features.py                 # Python version
│       ├── Dolo-simulations.ipynb                 # Advanced Dolo features
│       ├── Dolo-simulations.py                    # Python version
│       ├── Structural-changes-Qmod-Dolo.ipynb     # Comparative analysis
│       ├── Structural-changes-Qmod-Dolo.py        # Python version
│       ├── Class-Figures.ipynb                    # Generate paper figures
│       ├── Class-Figures.py                       # Python version
│       ├── Problem-set-template.ipynb             # Student exercises
│       └── Problem-set-template.py                # Python version
│
├── 🎨 Dolo Specifications
│   └── Dolo/
│       ├── Q-model.yaml             # Dolo model specification
│       └── DOLO_SETUP.md            # Dolo-specific setup notes
│
├── 🧪 Testing
│   └── tests/
│       ├── __init__.py              # Test package initialization
│       ├── test_qmod.py             # Comprehensive unit tests
│       └── pytest.ini               # Pytest configuration
│
├── 📊 Outputs & Figures
│   └── Figures/                     # Generated plots and diagrams
│       ├── CorporateTaxReduction.*  # Tax policy simulation
│       ├── ITCIncrease.*            # Investment tax credit analysis
│       └── ProductivityIncrease.*   # Productivity shock analysis
│
├── ⚙️ Configuration
│   ├── pyproject.toml               # Python project configuration
│   ├── pytest.ini                   # Test configuration
│   └── .gitignore                   # Git ignore patterns
│
└── 🌐 Binder Configuration
    └── binder/
        ├── environment.yml          # Conda environment for Binder
        └── requirements.txt         # Pip requirements for Binder

```

---

## 📚 Documentation Files

### Installation & Setup

| File | Purpose | When to Use |
|------|---------|-------------|
| **[README.md](README.md)** | Project overview, quick installation | First file to read |
| **[QUICKSTART.md](QUICKSTART.md)** | Step-by-step beginner guide | Never installed Python before |
| **[INSTALLATION.md](INSTALLATION.md)** | Detailed installation instructions | Installation problems |
| **[TROUBLESHOOTING.md](TROUBLESHOOTING.md)** | Common issues & solutions | Something's not working |
| **[DOLO_SETUP.md](Dolo/DOLO_SETUP.md)** | Dolo-specific configuration | Using Dolo features |

### Understanding the Code

| File | Purpose | When to Use |
|------|---------|-------------|
| **[INDEX.md](INDEX.md)** | This file - repository navigation | Finding specific content |
| **[IMPROVEMENTS.md](IMPROVEMENTS.md)** | Code quality enhancements made | Understanding code structure |
| **[CHANGES.md](CHANGES.md)** | Recent changes & updates | What's new? |
| **[PROPOSED_IMPROVEMENTS.md](PROPOSED_IMPROVEMENTS.md)** | Future enhancement plans | Contributing ideas |

### Theory & Background

| Resource | Type | Link |
|----------|------|------|
| **Q-Model Lecture Notes** | PDF | [Carroll's Lecture Notes](http://www.econ2.jhu.edu/people/ccarroll/public/lecturenotes/Investment/qModel/) |
| **Abel-Hayashi Papers** | Academic | See lecture notes references |
| **Dolo Documentation** | Online Docs | [Dolo ReadTheDocs](https://dolo.readthedocs.io/) |

---

## 💻 Core Code

### Main Implementation: `Qmod/q-investment.py`

**What it contains:** Complete implementation of the Q-investment model

**Key Classes:**
- `Qmod` - Main model class

**Key Methods:**

| Method | Purpose | Returns |
|--------|---------|---------|
| `__init__()` | Initialize model with parameters | Qmod instance |
| `solve()` | Solve for steady state & policy function | None (sets attributes) |
| `simulate()` | Simulate dynamics over time | Array of capital path |
| `phase_diagram()` | Plot phase diagram | matplotlib figure |
| `shoot()` | Shooting algorithm for dynamics | Array of capital & lambda |
| `find_k1()` | Find optimal k1 given k0 | Scalar k1 |
| `eulerError()` | Calculate Euler equation error | Scalar error |

**Key Attributes (after solving):**

| Attribute | Description | Type |
|-----------|-------------|------|
| `kss` | Steady-state capital | float |
| `lambdaSS` | Steady-state shadow value | float |
| `P` | Capital grid for policy function | array |
| `k1` | Policy function (next period capital) | array |

**Import and Use:**
```python
from Qmod import Qmod

# Create model with default parameters
model = Qmod()

# Or customize parameters
model = Qmod(beta=0.96, alpha=0.36, delta=0.10)

# Solve the model
model.solve()

# Access results
print(f"Steady-state capital: {model.kss:.4f}")
print(f"Shadow value: {model.lambdaSS:.4f}")
```

### Package Structure: `Qmod/__init__.py`

**What it does:** Makes Qmod importable as a package

**Enables:**
```python
from Qmod import Qmod  # Import the class directly
```

---

## 📓 Examples & Tutorials

### For Beginners

#### 1. **[Qmod-basic-features.ipynb](Examples/Qmod-basic-features.ipynb)** ⭐ START HERE

**What you'll learn:**
- How to create a Qmod instance
- Solving the model
- Interpreting steady-state results
- Simulating dynamics
- Plotting phase diagrams
- Policy function analysis

**Prerequisites:** None - this is the starting point

**Time:** 20-30 minutes

**Run it:**
```bash
jupyter notebook Examples/Qmod-basic-features.ipynb
```

---

### For Intermediate Users

#### 2. **[Dolo-simulations.ipynb](Examples/Dolo-simulations.ipynb)**

**What you'll learn:**
- Using Dolo for model specification
- More complex simulation exercises
- Comparing Dolo vs. Qmod approaches
- Advanced solution methods

**Prerequisites:** Completed Qmod-basic-features.ipynb

**Time:** 30-45 minutes

**Key Topics:**
- YAML model specification
- Dolo's solution algorithms
- Stochastic simulations
- Impulse response functions

---

#### 3. **[Structural-changes-Qmod-Dolo.ipynb](Examples/Structural-changes-Qmod-Dolo.ipynb)**

**What you'll learn:**
- Analyzing structural changes (tax policy, productivity shocks)
- Comparing Qmod and Dolo results
- Dynamic adjustment analysis
- Phase diagram interpretation

**Prerequisites:** Both previous notebooks

**Time:** 45-60 minutes

**Key Topics:**
- Corporate tax reduction
- Investment tax credit increase
- Productivity shocks
- Transition dynamics

---

### For Advanced Users

#### 4. **[Class-Figures.ipynb](Examples/Class-Figures.ipynb)**

**What you'll learn:**
- Generating publication-quality figures
- Advanced plotting techniques
- Replicating lecture note figures

**Prerequisites:** Understanding of economic model

**Time:** 30 minutes

**Outputs:** PDF, PNG, SVG figures in `Figures/` directory

---

#### 5. **[Problem-set-template.ipynb](Examples/Problem-set-template.ipynb)**

**What you'll learn:**
- Template for student exercises
- Combining theory and computation
- Structured analysis framework

**Prerequisites:** All previous notebooks

**Use Case:** Teaching, problem sets, research exercises

---

### Python Script Versions

All notebooks have `.py` equivalents that can be run from command line:

```bash
python Examples/Qmod-basic-features.py
python Examples/Dolo-simulations.py
# etc.
```

**When to use scripts vs. notebooks:**
- **Notebooks:** Interactive exploration, learning, teaching
- **Scripts:** Batch processing, automation, production runs

---

## 🧪 Testing

### Unit Tests: `tests/test_qmod.py`

**What it tests:**
- Model initialization & parameter validation
- Economic functions (production, adjustment costs)
- Steady-state computation
- Policy function accuracy
- Simulation correctness
- Shooting algorithm
- Phase diagram components
- Edge cases

**Run all tests:**
```bash
pytest tests/
```

**Run with coverage:**
```bash
pytest tests/ --cov=Qmod --cov-report=html
```

**Run specific test:**
```bash
pytest tests/test_qmod.py::TestQmodInitialization::test_default_initialization
```

**Test Structure:**
- 33 total tests
- 8 test classes
- ~95% code coverage

---

## 🔧 Configuration Files

### `pyproject.toml`

**What it contains:**
- Project metadata (name, version, authors)
- Python version constraints (3.8-3.10)
- Core dependencies
- Optional dependency groups (`dolo`, `dev`)
- Package configuration

**Key sections:**

```toml
[project]
name = "q-investment"
requires-python = ">=3.8,<3.11"
dependencies = [...]

[project.optional-dependencies]
dolo = [...]    # Dolo-related packages
dev = [...]     # Development tools

[tool.pytest.ini_options]
testpaths = ["tests"]
```

### `pytest.ini`

**What it contains:**
- Test discovery patterns
- Test output configuration
- Warning filters

### `.gitignore`

**What it contains:**
- Files to exclude from version control
- Virtual environments (`.venv/`)
- Python bytecode (`__pycache__/`)
- Build artifacts
- IDE configurations

---

## 📊 Output & Figures

### `Figures/` Directory

Generated by running `Examples/Class-Figures.ipynb`

**Available Formats:**
- PDF (publication quality)
- PNG (presentations, web)
- SVG (vector graphics)
- TXT (underlying data)

**Figure Categories:**

| Figure | Description | Notebook |
|--------|-------------|----------|
| **CorporateTaxReduction*** | Impact of τ decrease | Structural-changes-Qmod-Dolo.ipynb |
| **ITCIncrease*** | Investment tax credit ψ increase | Structural-changes-Qmod-Dolo.ipynb |
| **ProductivityIncrease*** | TFP ω increase | Structural-changes-Qmod-Dolo.ipynb |

**File Naming:**
- `*-ant.pdf` - Anticipated policy change
- `*.pdf` - Unanticipated policy change

---

## 🎯 How Do I...?

### Installation & Setup

<details>
<summary><b>Install Q-Investment for the first time?</b></summary>

1. Check [QUICKSTART.md](QUICKSTART.md) for complete beginner guide
2. Or use quick installation:
   ```bash
   git clone https://github.com/llorracc/Q-Investment.git
   cd Q-Investment
   ./INSTALL.sh
   source .venv/bin/activate
   ```

</details>

<details>
<summary><b>Check if my system is ready to install?</b></summary>

Run the pre-flight check:
```bash
./CHECK.sh  # Linux/macOS
CHECK.bat   # Windows
```

</details>

<details>
<summary><b>Fix installation problems?</b></summary>

1. Read [TROUBLESHOOTING.md](TROUBLESHOOTING.md)
2. Run diagnostic: `./DEBUG.sh`
3. Check specific issues:
   - "uv not found" → Install uv first
   - "Python 3.10 not found" → Install Python 3.10
   - "Dolo import hangs" → Set `NUMBA_DISABLE_JIT=1`

</details>

<details>
<summary><b>Verify my installation works?</b></summary>

```bash
python -c "from Qmod import Qmod; from dolo import yaml_import; print('✅ Works!')"
```

</details>

---

### Using the Model

<details>
<summary><b>Create and solve a basic model?</b></summary>

```python
from Qmod import Qmod

# Create model with default parameters
model = Qmod()

# Solve for steady state and policy function
model.solve()

# Check results
print(f"Steady-state capital: {model.kss:.4f}")
print(f"Shadow value: {model.lambdaSS:.4f}")
```

See: [Qmod-basic-features.ipynb](Examples/Qmod-basic-features.ipynb)

</details>

<details>
<summary><b>Change model parameters?</b></summary>

```python
from Qmod import Qmod

# Specify custom parameters
model = Qmod(
    beta=0.96,      # Discount factor
    alpha=0.36,     # Capital share
    delta=0.10,     # Depreciation rate
    tau=0.35,       # Corporate tax rate
    omega=1.0,      # TFP level
    psi=0.0,        # Investment tax credit
    zeta=5.0        # Adjustment cost parameter
)

model.solve()
```

See docstring: `help(Qmod.__init__)`

</details>

<details>
<summary><b>Simulate the model dynamics?</b></summary>

```python
# After solving the model
path = model.simulate(
    k0=2.0,        # Initial capital
    periods=100    # Number of periods
)

# Plot the path
import matplotlib.pyplot as plt
plt.plot(path)
plt.xlabel('Period')
plt.ylabel('Capital')
plt.title('Capital Dynamics')
plt.show()
```

See: [Qmod-basic-features.ipynb](Examples/Qmod-basic-features.ipynb)

</details>

<details>
<summary><b>Plot the phase diagram?</b></summary>

```python
# After solving the model
fig, ax = model.phase_diagram()
plt.show()
```

See: [Qmod-basic-features.ipynb](Examples/Qmod-basic-features.ipynb)

</details>

<details>
<summary><b>Analyze a policy change?</b></summary>

```python
# Baseline model
baseline = Qmod(tau=0.35)
baseline.solve()

# Policy change (tax reduction)
policy = Qmod(tau=0.25)
policy.solve()

# Compare
print(f"Baseline capital: {baseline.kss:.4f}")
print(f"New capital: {policy.kss:.4f}")
print(f"Change: {policy.kss - baseline.kss:.4f}")
```

See: [Structural-changes-Qmod-Dolo.ipynb](Examples/Structural-changes-Qmod-Dolo.ipynb)

</details>

<details>
<summary><b>Use Dolo instead of Qmod?</b></summary>

```python
from dolo import yaml_import

# Load model from YAML file
model = yaml_import('Dolo/Q-model.yaml')

# Solve
dr = model.time_iteration()

# Simulate
sim = model.simulate(dr, n_exp=1000, horizon=100)
```

See: [Dolo-simulations.ipynb](Examples/Dolo-simulations.ipynb)

</details>

---

### Development & Testing

<details>
<summary><b>Run the test suite?</b></summary>

```bash
# All tests
pytest tests/

# Verbose output
pytest tests/ -v

# With coverage
pytest tests/ --cov=Qmod

# Specific test
pytest tests/test_qmod.py::test_default_initialization
```

</details>

<details>
<summary><b>Add a new test?</b></summary>

1. Open `tests/test_qmod.py`
2. Add a new test function or class
3. Follow existing patterns:
   ```python
   def test_my_feature():
       model = Qmod()
       # ... your test code
       assert expected == actual
   ```
4. Run: `pytest tests/test_qmod.py::test_my_feature`

</details>

<details>
<summary><b>Understand the code structure?</b></summary>

Read in this order:
1. [Qmod/__init__.py](Qmod/__init__.py) - Package setup
2. [Qmod/q-investment.py](Qmod/q-investment.py) - Main implementation
   - Start with `__init__` method
   - Then `solve()` method
   - Then explore others as needed
3. [IMPROVEMENTS.md](IMPROVEMENTS.md) - Code quality notes

</details>

<details>
<summary><b>Modify the Qmod class?</b></summary>

1. Edit `Qmod/q-investment.py`
2. Add docstrings for new methods (NumPy style)
3. Add tests in `tests/test_qmod.py`
4. Run tests: `pytest tests/`
5. Test with example: `jupyter notebook Examples/Qmod-basic-features.ipynb`

</details>

---

### Notebooks & Examples

<details>
<summary><b>Run a Jupyter notebook?</b></summary>

```bash
# Start Jupyter
jupyter notebook

# Navigate to Examples/ folder in browser
# Click on notebook to open

# Or directly:
jupyter notebook Examples/Qmod-basic-features.ipynb
```

</details>

<details>
<summary><b>Run notebook from command line?</b></summary>

```bash
# Execute notebook without opening browser
jupyter nbconvert --to notebook --execute Examples/Qmod-basic-features.ipynb

# Or use the .py version
python Examples/Qmod-basic-features.py
```

</details>

<details>
<summary><b>Convert notebook to other formats?</b></summary>

```bash
# To HTML
jupyter nbconvert --to html Examples/Qmod-basic-features.ipynb

# To PDF (requires LaTeX)
jupyter nbconvert --to pdf Examples/Qmod-basic-features.ipynb

# To Python script
jupyter nbconvert --to script Examples/Qmod-basic-features.ipynb
```

</details>

<details>
<summary><b>Create my own analysis notebook?</b></summary>

1. Copy a template:
   ```bash
   cp Examples/Qmod-basic-features.ipynb MyAnalysis.ipynb
   ```
2. Open in Jupyter:
   ```bash
   jupyter notebook MyAnalysis.ipynb
   ```
3. Modify and run cells
4. Save and export results

</details>

---

### Figures & Output

<details>
<summary><b>Generate the lecture note figures?</b></summary>

```bash
jupyter notebook Examples/Class-Figures.ipynb
```

Figures are saved to `Figures/` directory in PDF, PNG, and SVG formats.

</details>

<details>
<summary><b>Customize figure output?</b></summary>

In the notebook or script:
```python
import matplotlib.pyplot as plt

# Your plotting code here
fig, ax = model.phase_diagram()

# Customize
ax.set_title('My Custom Title')
ax.set_xlabel('Capital')

# Save in your preferred format
plt.savefig('my_figure.pdf', bbox_inches='tight')
plt.savefig('my_figure.png', dpi=300, bbox_inches='tight')
```

</details>

---

### Getting Help

<details>
<summary><b>Understand what a method does?</b></summary>

```python
from Qmod import Qmod

# View docstring
help(Qmod.solve)

# In Jupyter/IPython
Qmod.solve?

# View all methods
help(Qmod)
```

</details>

<details>
<summary><b>Find example usage of a feature?</b></summary>

1. Check notebooks in `Examples/` directory
2. Search in this INDEX.md
3. Look at `tests/test_qmod.py` for usage patterns

</details>

<details>
<summary><b>Report a bug or issue?</b></summary>

1. Check if it's a known issue: [TROUBLESHOOTING.md](TROUBLESHOOTING.md)
2. Open a GitHub issue: [Q-Investment Issues](https://github.com/llorracc/Q-Investment/issues)
3. Include:
   - Python version
   - Error message
   - Minimal example to reproduce

</details>

<details>
<summary><b>Contribute to the project?</b></summary>

1. Fork the repository
2. Create a branch: `git checkout -b my-feature`
3. Make changes
4. Add tests
5. Run test suite: `pytest tests/`
6. Submit pull request

</details>

---

## 🔍 Quick Reference

### Essential Commands

```bash
# Installation
./INSTALL.sh                                    # Install everything
source .venv/bin/activate                       # Activate environment

# Verification
python -c "from Qmod import Qmod"              # Test imports

# Running Examples
jupyter notebook Examples/                      # Open notebooks
python Examples/Qmod-basic-features.py         # Run script

# Testing
pytest tests/                                   # Run all tests
pytest tests/ -v                                # Verbose output
pytest tests/ --cov=Qmod                        # With coverage

# Help
./DEBUG.sh                                      # Diagnostic script
```

### Essential Python

```python
# Import
from Qmod import Qmod

# Basic workflow
model = Qmod()                                  # Create
model.solve()                                   # Solve
path = model.simulate(k0=2.0, periods=100)     # Simulate
fig, ax = model.phase_diagram()                # Visualize

# Access results
model.kss                                       # Steady-state capital
model.lambdaSS                                  # Steady-state shadow value
model.P                                         # Policy function grid
model.k1                                        # Policy function values

# Dolo
from dolo import yaml_import
dolo_model = yaml_import('Dolo/Q-model.yaml')
```

### File Locations Quick Reference

| I want to... | Look in... |
|-------------|------------|
| Learn the basics | `Examples/Qmod-basic-features.ipynb` |
| Understand installation | `INSTALLATION.md` |
| Fix a problem | `TROUBLESHOOTING.md` |
| See the code | `Qmod/q-investment.py` |
| Run tests | `tests/test_qmod.py` |
| View figures | `Figures/` |
| Check configuration | `pyproject.toml` |
| Use Dolo | `Dolo/Q-model.yaml` |

### Parameter Quick Reference

| Parameter | Symbol | Default | Description |
|-----------|--------|---------|-------------|
| `beta` | β | 0.96 | Discount factor |
| `alpha` | α | 0.36 | Capital share in production |
| `delta` | δ | 0.10 | Depreciation rate |
| `tau` | τ | 0.35 | Corporate tax rate |
| `omega` | ω | 1.0 | Total factor productivity |
| `psi` | ψ | 0.0 | Investment tax credit |
| `zeta` | ζ | 5.0 | Adjustment cost parameter |

---

## 📞 Support Resources

### Within Repository

- **[QUICKSTART.md](QUICKSTART.md)** - Complete beginner guide
- **[INSTALLATION.md](INSTALLATION.md)** - Installation help
- **[TROUBLESHOOTING.md](TROUBLESHOOTING.md)** - Problem solving
- **[IMPROVEMENTS.md](IMPROVEMENTS.md)** - Code documentation
- **[CHANGES.md](CHANGES.md)** - Change log

### External Resources

- **Theory:** [Carroll's Q-Model Lecture Notes](http://www.econ2.jhu.edu/people/ccarroll/public/lecturenotes/Investment/qModel/)
- **Dolo:** [Dolo Documentation](https://dolo.readthedocs.io/)
- **GitHub:** [Q-Investment Repository](https://github.com/llorracc/Q-Investment)
- **Issues:** [Report Problems](https://github.com/llorracc/Q-Investment/issues)
- **Binder:** [Try Online](https://mybinder.org/v2/gh/llorracc/Q-Investment/master)

---

## 🎓 Learning Path

### Path 1: Economist (Theory → Code)

1. Read [lecture notes](http://www.econ2.jhu.edu/people/ccarroll/public/lecturenotes/Investment/qModel/)
2. Open [Qmod-basic-features.ipynb](Examples/Qmod-basic-features.ipynb)
3. Connect theory to implementation
4. Try [Structural-changes-Qmod-Dolo.ipynb](Examples/Structural-changes-Qmod-Dolo.ipynb)
5. Read [q-investment.py](Qmod/q-investment.py) to understand algorithms

### Path 2: Programmer (Code → Theory)

1. Install following [QUICKSTART.md](QUICKSTART.md)
2. Read [q-investment.py](Qmod/q-investment.py) source code
3. Run [tests](tests/test_qmod.py) to understand behavior
4. Explore [Qmod-basic-features.ipynb](Examples/Qmod-basic-features.ipynb)
5. Read [lecture notes](http://www.econ2.jhu.edu/people/ccarroll/public/lecturenotes/Investment/qModel/) for theory

### Path 3: Student (Guided Learning)

1. Follow [QUICKSTART.md](QUICKSTART.md) for installation
2. Work through [Qmod-basic-features.ipynb](Examples/Qmod-basic-features.ipynb)
3. Try [Problem-set-template.ipynb](Examples/Problem-set-template.ipynb)
4. Read relevant [lecture notes](http://www.econ2.jhu.edu/people/ccarroll/public/lecturenotes/Investment/qModel/)
5. Experiment with parameter changes

### Path 4: Researcher (Quick Start)

1. Quick install: `./INSTALL.sh && source .venv/bin/activate`
2. Skim [Structural-changes-Qmod-Dolo.ipynb](Examples/Structural-changes-Qmod-Dolo.ipynb)
3. Copy and adapt code for your research
4. Reference [q-investment.py](Qmod/q-investment.py) for details
5. Cite the package

---

**Last Updated:** December 2024  
**Maintainer:** Christopher D. Carroll  
**Contributors:** See git log

---

*Having trouble finding something? Open an [issue](https://github.com/llorracc/Q-Investment/issues) and we'll add it to this index!*

