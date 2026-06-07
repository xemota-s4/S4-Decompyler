#  S4Decompiler

<p align="rigth">
&#x20; <img src="https://img.shields.io/badge/version-0.0.1-blue.svg" />
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
**For the 3th decomplier, this script uses a standalone version of `unpyc3`, not need to be accessible from your PATH.**
---



\# 📥 Installation



Clone the repository:



```bash

git clone https://github.com/yourusername/uncompyle-sims4-game.git

cd uncompyle-sims4-game

```



Create the following directory:



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



Typical location:



```text

C:\\Program Files\\EA Games\\The Sims 4\\Data\\Simulation\\Gameplay

```



\---



\# 🚀 Usage



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



\---



\# 📂 Project Structure



```text

.

├── UncompyleSims4.bat

├── GameFiles

│   ├── base.zip

│   ├── core.zip

│   └── simulation.zip

├── Uncompiling.log

└── Output

&#x20;   ├── base

&#x20;   ├── core

&#x20;   └── simulation

```



\---



\# ⚙️ Workflow



```text

ZIP Archives

&#x20;     │

&#x20;     ▼

Extraction

&#x20;     │

&#x20;     ▼

Recursive Scan

&#x20;     │

&#x20;     ▼

decompyle3

&#x20;     │

&#x20;     ├── Success ✔

&#x20;     │

&#x20;     ▼

uncompyle6

&#x20;     │

&#x20;     ├── Success ✔

&#x20;     │

&#x20;     ▼

unpyc3

&#x20;     │

&#x20;     ├── Success ✔

&#x20;     │

&#x20;     ▼

Failed ✖

```



\---



\# 📸 Screenshots



\### Startup



```text

\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_



&#x20;     Uncompyle Sims4 Game - v0.0.1



\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_

```



\### Extraction



```text

\[DETECTING] ZIP found : base.zip

\[DETECTING] ZIP found : core.zip

\[DETECTING] ZIP found : simulation.zip

```



\### Decompilation



```text

\[OK] Decompiled with decompyle3

\[OK] Decompiled with uncompyle6

\[OK] Decompiled with unpyc3

```



\---



\# 📊 Example Results



```text

\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_



UNCOMPILING RESULTS



.pyc files found         : 15234

Successfully decompiled  : 14887

Failed                   : 347



\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_

```



\---



\# 🗺️ Roadmap



\## v0.1



\* \[ ] Proper semantic versioning

\* \[ ] Improved version validation

\* \[ ] Better error handling

\* \[ ] Configuration file support



\## v0.2



\* \[ ] Multi-threaded decompilation

\* \[ ] Progress bar

\* \[ ] Colored console output



\## v0.3



\* \[ ] Automatic dependency installation

\* \[ ] GUI interface



\## v1.0



\* \[ ] Full Sims 4 gameplay package support

\* \[ ] Plugin architecture

\* \[ ] Export reports (HTML / JSON)



\---



\# 🤝 Contributing



Contributions are welcome.



1\. Fork the repository

2\. Create a feature branch



```bash

git checkout -b feature/my-feature

```



3\. Commit your changes



```bash

git commit -m "Add new feature"

```



4\. Push your branch



```bash

git push origin feature/my-feature

```



5\. Open a Pull Request



\---



\# ⚠️ Disclaimer



This project is intended for:



\* Educational purposes

\* Research

\* Modding analysis

\* Understanding Python bytecode structures



This project is \*\*not affiliated with, endorsed by, or supported by EA Games, Maxis, or Electronic Arts.\*\*



Users are responsible for complying with all applicable software licenses, terms of service, and local laws.



\---



\# 📄 License



MIT License



See the `LICENSE` file for details.



\---



<p align="center">

Made with ❤️ for the Sims 4 modding community

</p>



