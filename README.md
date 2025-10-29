# C Project Template

This project is representing a selfmade C project template. It is covering the most important aspects of a C project structure. The project is intended to be used as a template for embedded C projects, but can be used for other C projects as well.

It is using CMake as build system and is structured to separate application specific code from reusable libraries and modules. Unit tests are supported as well.
Static code analysis using Clang-Tidy and CMake-Tidy as well as code formatting using Clang-Format and CMake-Format is integrated into the project structure.

## Development Setup

The development takes place in Visual Studio Code and is using WSL: Ubuntu. The application code is cross-compiled using the ARM GCC toolchain for the Atmel SAM3X8E microcontroller. You can deploy the compiled binary using BOSSA-CLI to the connected Arduino Due board.

## File Structure

``` text
├── app                                 // Application specific code
│   ├── CMakeLists.txt
│   ├── app.cpp
│   ├── *.c
│   └── *.h
├── build (unversioned)                 // CMake build tree
│   └── *
├── cmake
│   ├── templates                       // CMake template files used by configure_file()
│   │   └── *.*.in
│   └── *.cmake                         // CMake helper modules and scripts
├── docs                                // Documentation
│   ├── design
│   │   ├── build_graph.svg
│   │   └── *
│   ├── reports
│   │   ├── clang-format                // Clang-Format reports: YYYYMMDD-HHMMSS-clang-format.txt
│   │   │   └── *.txt
│   │   ├── clang-tidy                  // Clang-Tidy reports: YYYYMMDD-HHMMSS-clang-tidy.txt
│   │   │   └── *.txt
│   │   ├── cmake-lint (BUG)            // CMake-Lint reports: YYYYMMDD-HHMMSS-cmake-lint.txt
│   │   │   └── *.txt
│   │   └── *
│   └── *
├── external                            // 3rd Party code, libraries or repositories
│   ├── arduino_core_sam-src            // Arduino core library for Atmel SAM3 microcontroller (Arduino Due)
│   │   └── *
│   └── *
├── include                             // Public API headers
│   └── <ProjectName>
│       └── *.h
├── lib                                 // Basic libraries
│   ├── <LibName>
│   │   ├── CMakeLists.txt
│   │   ├── <LibName>.c
│   │   └── <LibName>.h
│   └── *
├── output (unversioned)                // Output files (e.g. binaries, hex files, includes etc.)
│   ├── bin                             // Binaries
│   │   └── *
│   └── include                         // Public API headers
│       └── <ProjectName>
│           └── *.h
├── scripts                             // Build and utility scripts
│   ├── build.sh
│   ├── clean.sh
│   ├── flash.sh
│   ├── report-clang-format.sh
│   ├── report-clang-tidy.sh
│   ├── report-cmake-lint.sh
│   ├── run-clang-format.sh
│   ├── run-cmake-format.sh
│   ├── test.sh
│   └── *.sh
├── src                                 // Reusable source code
│   ├── <ModuleName>
│   │   ├── CMakeLists.txt
│   │   ├── <ModuleName>.c
│   │   └── <ModuleName>.h
│   └── *
├── tests                               // Unit tests
│   ├── CMakeLists.txt
│   ├── test_*.c
│   └── test_*.h
├── toolchains                          // Toolchain files for cross-compilation
│   └── arm-gcc-sam3.cmake
├── .clang-format
├── .clang-tidy
├── .cmake-format
├── .gitignore
├── CMakeLists.txt                      // CMake: Top-level project description
├── CMakePresets.json                   // CMake: Presets for configure and build
├── LICENSE
├── README.md
├── TODO.md
└── C_Project_Template.code-workspace   // VS Code project
```

## Setup

### Setup the Project

1. Move to the desired project directory

    ``` bash
    mkdir ~/C_Prj_Template
    cd ~/C_Prj_Template
    ```

2. Clone Git repository into the current directory

    ``` bash
    git clone https://gitlab.com/Herbert-Engineering/c-project-template.git .
    ```

3. Open the workspace from file

4. Install required extensions on the remote drive

5. Add script directory to PATH variable for easy script execution

    ``` bash
    export PATH=$PATH:~/C_Prj_Template/scripts
    ```

### Setup WSL-System

1. Update WSL system

    ``` bash
    sudo apt-get update && sudo apt-get upgrade -y
    ```

2. Install build system

    ``` bash
    sudo apt-get install gcc cmake
    ```

3. Install MCU specific toolchain

    ``` bash
    sudo apt-get install gcc-arm-none-eabi
    sudo apt-get install bossa-cli
    ```

4. Install additional tools

    ``` bash
    sudo apt-get install git
    sudo apt-get install doxygen
    sudo apt-get install graphviz
    sudo apt-get install clang-format
    sudo apt-get install clang-tidy
    sudo apt-get install cmake-format
    sudo apt-get install usbutils
    ```

5. Mount USB devices in WSL

    Open PowerShell as Administrator and run:

    ``` powershell
    # Identify USB devices
    usbipd list

    # Bind and attach USB device to WSL
    usbipd bind --busid <busid>
    usbipd attach --wsl --busid <busid>

    # Troubleshooting: To remove persistent USB device
    usbipd unbind --gbusid <busid>
    ```

    Open a Bash shell and run:

    ``` bash
    # Troubleshooting: Add user to dialout group to get access to serial devices
    sudo usermod -aG dialout $USER
    ```

6. Identify the serial port of the connected device using the following commands:

    ``` bash
    lsusb
    ls /dev
    dmesg
    ```

## Build

``` bash
cd ~/C_Prj_Template
./scripts/build.sh
```

## Formatting

To format the code using clang-format or cmake-format, run the following command from the project root directory:

### Check C Code Format

``` bash
cd ~/C_Prj_Template
./scripts/report-clang-format.sh
```

### Format C Code

``` bash
cd ~/C_Prj_Template
./scripts/run-clang-format.sh
```

### Format CMake Code

``` bash
cd ~/C_Prj_Template
./scripts/run-cmake-format.sh
```

## Linting

To lint the code using clang-tidy or cmake-lint, run the following command from the project root directory:

### Check C Code with Clang-Tidy

``` bash
cd ~/C_Prj_Template
./scripts/report-clang-tidy.sh
```

### Check CMake Code with CMake-Lint

Bug: Currently, CMake-Lint is not working as expected. The script is present but needs to be fixed!!!

``` bash
cd ~/C_Prj_Template
./scripts/report-cmake-lint.sh
```

## Flashing

To flash the compiled binary to the connected device make sure to set the right interface in the CMakePresets.json file
 and run the following command from the project root directory:

``` bash
cd ~/C_Prj_Template
./scripts/flash.sh
```

## VS Code Setup

### Extensions

- [C/C++ Extension Pack](https://marketplace.visualstudio.com/items?itemName=ms-vscode.cpptools-extension-pack)
- [Remote Development](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.vscode-remote-extensionpack)
- [Markdown Preview Enhanced](https://marketplace.visualstudio.com/items?itemName=shd101wyy.markdown-preview-enhanced)
- [Markdownlint](https://marketplace.visualstudio.com/items?itemName=DavidAnson.vscode-markdownlint)
- [Todo Tree](https://marketplace.visualstudio.com/items?itemName=Gruntfuggly.todo-tree)
- [Peacock](https://marketplace.visualstudio.com/items?itemName=johnpapa.vscode-peacock)
- [Data Wrangler](https://marketplace.visualstudio.com/items?itemName=ms-toolsai.datawrangler)
- [CMake Tools](https://marketplace.visualstudio.com/items?itemName=ms-vscode.cmake-tools)
- [CMake Language Support](https://marketplace.visualstudio.com/items?itemName=josetr.cmake-language-support-vscode)
- [CMake-Format](https://marketplace.visualstudio.com/items?itemName=cheshirekow.cmake-format)
- [CodeSnap](https://marketplace.visualstudio.com/items?itemName=adpyke.codesnap)
- [Hex Editor](https://marketplace.visualstudio.com/items?itemName=ms-vscode.hexeditor)
- [Doxygen](https://marketplace.visualstudio.com/items/?itemName=bbenoist.Doxygen)
- [Prettier](https://marketplace.visualstudio.com/items?itemName=esbenp.prettier-vscode)
- [Better Comments](https://marketplace.visualstudio.com/items?itemName=aaron-bond.better-comments)
- [Path Intellisense](https://marketplace.visualstudio.com/items?itemName=christian-kohler.path-intellisense)
- [Partial Diff](https://marketplace.visualstudio.com/items?itemName=ryu1kn.partial-diff)
- [YAML](https://marketplace.visualstudio.com/items?itemName=redhat.vscode-yaml)
- [Code Runner](https://marketplace.visualstudio.com/items?itemName=formulahendry.code-runner)
- [Makefile Tools](https://marketplace.visualstudio.com/items?itemName=ms-vscode.makefile-tools)

## Source

- [CMake Tutorial](https://cmake.org/cmake/help/v4.0/guide/tutorial/index.html#guide:CMake%20Tutorial)
- [Clang-Tidy](https://clang.llvm.org/extra/clang-tidy/)
- [VSCode - Integrate with External Tools via Tasks](https://code.visualstudio.com/docs/editor/tasks#vscode)
- [VSCode - Launch Configurations](https://code.visualstudio.com/docs/editor/debugging#_launch-configurations)
- [VSCode - C/C++ for Visual Studio Code](https://code.visualstudio.com/docs/languages/cpp)
- [WSL - Connect USB Devices](https://learn.microsoft.com/de-de/windows/wsl/connect-usb)
