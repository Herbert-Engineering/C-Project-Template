#!/bin/bash

# Identify project root directory
cd "$(dirname "$0")"
SCRIPT_DIR="$(pwd)"
ROOT_DIR=${SCRIPT_DIR}/..
cd ${ROOT_DIR}
echo "Project Root Directory: ${ROOT_DIR}"


# Create required directories if they do not exist
mkdir -p ${ROOT_DIR}/build
mkdir -p ${ROOT_DIR}/build/due-debug
mkdir -p ${ROOT_DIR}/build/due-release
mkdir -p ${ROOT_DIR}/output
mkdir -p ${ROOT_DIR}/docs/design
mkdir -p ${ROOT_DIR}/include/${PRJ_NAME}


### DEBUG BUILD
# CONFIGURE Phase
cmake --graphviz=${ROOT_DIR}/build/build_graph.dot --preset=config-due-debug -B ${ROOT_DIR}/build/due-debug -S ${ROOT_DIR}
if [ -f ${ROOT_DIR}/build/build_graph.dot ]; then
    echo "Build graph generated successfully."
    dot -Tsvg ${ROOT_DIR}/build/build_graph.dot -o ${ROOT_DIR}/docs/design/build_graph.svg
else
    echo "Failed to generate build graph."
fi

# BUILD Phase
cmake --build ${ROOT_DIR}/build/due-debug --preset=build-due-debug

# INSTALL Phase
# Install the project
cmake --install ${ROOT_DIR}/build/due-debug
