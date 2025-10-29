#!/usr/bin/env bash

# Identify project root directory
cd "$(dirname "$0")"
SCRIPT_DIR="$(pwd)"
ROOT_DIR=${SCRIPT_DIR}/..
cd ${ROOT_DIR}

# Inlined code formatting using cmake-format on all relevant CMake files in the project.
cmake --build ./build/due-debug --target run-cmake-format