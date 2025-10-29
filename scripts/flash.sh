#!/usr/bin/env bash

# Identify project root directory
cd "$(dirname "$0")"
SCRIPT_DIR="$(pwd)"
ROOT_DIR=${SCRIPT_DIR}/..
cd ${ROOT_DIR}

# Flash the compiled firmware to the Arduino DUE board.
cmake --build ./build/due-debug --target flash-due