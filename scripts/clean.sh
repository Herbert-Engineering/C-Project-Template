#! /bin/bash

# Identify project root directory
cd "$(dirname "$0")"
SCRIPT_DIR="$(pwd)"
ROOT_DIR=${SCRIPT_DIR}/..

# Clean output directory
rm -rf ${ROOT_DIR}/output/*
> ${ROOT_DIR}/output/.gitkeep

# Clean build directory
rm -rf ${ROOT_DIR}/build/*
> ${ROOT_DIR}/build/.gitkeep

# Clean external directory
rm -rf ${ROOT_DIR}/external/*
> ${ROOT_DIR}/external/.gitkeep
