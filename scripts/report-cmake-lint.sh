#!/usr/bin/env bash

# Identify project root directory
cd "$(dirname "$0")"
SCRIPT_DIR="$(pwd)"
ROOT_DIR=${SCRIPT_DIR}/..
cd ${ROOT_DIR}

#
cmake --build ./build/due-debug --target report-cmake-lint