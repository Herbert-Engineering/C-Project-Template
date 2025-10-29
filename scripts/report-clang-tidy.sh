#! /bin/bash

# Identify project root directory
cd "$(dirname "$0")"
SCRIPT_DIR="$(pwd)"
ROOT_DIR=${SCRIPT_DIR}/..
cd ${ROOT_DIR}

# This script runs clang-format on all relevant source files in the project.
cmake --build ./build/due-debug --target report-clang-tidy