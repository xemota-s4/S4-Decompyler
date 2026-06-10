#  S4Decompiler

<p align="rigth">
&#x20; <img src="https://img.shields.io/badge/version-0.1.0-blue.svg" />
&#x20; <img src="https://img.shields.io/badge/platform-Windows-green.svg" />
&#x20; <img src="https://img.shields.io/badge/python-3.7%2B-yellow.svg" />
&#x20; <img src="https://img.shields.io/badge/license-MIT-orange.svg" />
</p>


Automatically extract and decompile Python bytecode (`.pyc`) files from **The Sims 4** gameplay archives.
This utility streamlines the reverse-engineering workflow by:

* Extracting game archives (`base.zip`, `core.zip`, `simulation.zip`)
* Scanning all extracted directories recursively
* Decompiling `.pyc` files using multiple fallback engines
* Generating execution logs and statistics
* Measuring total execution time
---


## 📖 How to read this readme
* [Features](#-features)
* [Requirements](#-requirements)
* [Installation](#-installation)
* [Usage](#-usage)
* [Project Structure](#-project-structure)
* [Workflow](#️-workflow)
* [Example Results](#-example-results)
* [Roadmap](#️-roadmap)
* [Contributing](#-contributing)
* [Disclaimer](#️-disclaimer)
* [License](#-license)
---


# ✨ Features
* Automatic ZIP archive extraction
* Recursive `.pyc` discovery
* Multiple decompilation engines:
    - decompyle3
    - uncompyle6
    - unpyc3
* Detailed logging
* Success / failure statistics
* Execution time measurement
* Simple Windows Batch implementation
---



# 📦 Requirements

## Software
* Windows 10 / 11
* Python 3.7+
* PowerShell

## Python Packages
```bash
pip install decompyle3==3.9.0
pip install uncompyle6==3.9.0
```
Those scripts are saved in the ./scripts folder of your python installation directory.
Please save them inside the PATH environmental variable.  
Once it is done, test directly with your command prompt. You shall see "version 3.9.0".

```bash
decompyle3 --version
uncompyle6 --version
```
For the 3th decomplier, this script uses a **standalone version** of `unpyc3`, **not need to be accessible from your PATH**.

---

# 📥 Installation
Clone the repository:

```bash
git clone https://github.com/xemota-s4/S4-Decompyler.git
cd Uncompyle_tool
```
Create the following directory (version **0.0.1** of the script):

```text
GameFiles/
```

Copy the Sims 4 gameplay archives into it:
```text
GameFiles/
├── base.zip
├── core.zip
└── simulation.zip
```

Typical location of these .zip files:
```text
C:\\Program Files\\EA Games\\The Sims 4\\Data\\Simulation\\Gameplay
```
---

# Usage
Run:

```bat
UncompyleSims4.bat
```
The script will ask for:

```text
Output directory name :
Path where output directory should created :
```
Example:

```text
Output directory name : Sims4Source
Path where output directory should created : D:\\Projects
```

Result:
```text
D:\\Projects\\Sims4Source
```
---



# 📂 Project Structure

```text
.
├── UncompyleSims4.bat
├── GameFiles
│   ├── base.zip
│   ├── core.zip
│   └── simulation.zip
├── Uncompiling.log
└── Output
    ├── base
    ├── core
    └── simulation
```
---


# ⚙️ Workflow
```text
ZIP Archives
    │
    ▼
Extraction
    │
    ▼
Recursive Scan
    │
    ▼
decompyle3
    │
    ├── Success ✔
    │
    ▼
uncompyle6
    │
    ├── Success ✔
    │
    ▼
unpyc3
    │
    ├── Success ✔
    │
    ▼
Failed ✖

```
---



# Screenshots
### Extraction
```text
[DETECTING] ZIP found : base.zip
[DETECTING] ZIP found : core.zip
[DETECTING] ZIP found : simulation.zip
```

### Decompilation

```text
[OK] Decompiled with decompyle3
[OK] Decompiled with uncompyle6
[OK] Decompiled with unpyc3
```
---


# 📊 Example Results



```text
__________________________________________________________________________________
UNCOMPILING RESULTS

.pyc files found         : 800
Successfully decompiled  : 780
Failed                   : 20
__________________________________________________________________________________
```
---


# ⚠️ Disclaimer

This project is intended for:
* Research
* Modding analysis
* give a simple tool to S4 community for modding

This project is **not affiliated with, endorsed by, or supported by EA Games, Maxis, or Electronic Arts.**
Users are responsible for complying with all applicable software licenses, terms of service, and local laws.

---
