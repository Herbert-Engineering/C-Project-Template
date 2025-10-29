#! /bin/bash

# Identify project root directory
cd "$(dirname "$0")"
SCRIPT_DIR="$(pwd)"
ROOT_DIR=${SCRIPT_DIR}/..
cd ${ROOT_DIR}

# Dry-run clang-format to check code style on all relevant source files in the project.
cmake --build ./build/due-debug --target report-clang-format