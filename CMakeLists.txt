# Required CMake version
cmake_minimum_required(VERSION 4.0)

# Project
project(
    "CPrjTemplate"
    VERSION 1.0.0
    DESCRIPTION "C Project Template"
    HOMEPAGE_URL "https://herbert-engineering.com"
    LANGUAGES C CXX ASM)

# Define executable name
set(EXE_NAME "${PROJECT_NAME}_main")

# Configure CMake verbose mode to control the debug output
set(CMAKE_VERBOSE_MAKEFILE OFF)

# Set CMake to export compile commands for tools like clang-tidy
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

# Set C and C++ standard versions
set(CMAKE_C_STANDARD 99)
set(CMAKE_C_STANDARD_REQUIRED ON)
set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# Compiler Requirements
add_library(${PROJECT_NAME}_compiler_flags INTERFACE)
add_library(${PROJECT_NAME}_compiler_warnings INTERFACE)

target_compile_options(${PROJECT_NAME}_compiler_warnings INTERFACE -Wall -Wextra -Wpedantic -Werror)

target_compile_definitions(
    ${PROJECT_NAME}_compiler_flags
    INTERFACE F_CPU=${DUE_F_CPU}
              ARDUINO=${DUE_ARDUINO}
              ${DUE_SAM}
              ${DUE_ARCH}
              ${DUE_DEVICE}
              USB_VID=${DUE_USB_VID}
              USB_PID=${DUE_USB_PID}
              USBCON
              USB_MANUFACTURER="${DUE_USB_MANUFACTURER}"
              USB_PRODUCT="${DUE_USB_PRODUCT}")

target_compile_options(
    ${PROJECT_NAME}_compiler_flags
    INTERFACE -c
              -g # Debugging information format
              -Os # Optimize for size
              -nostdlib # Do not use the standard system startup files or libraries
              --param
              max-inline-insns-single=500
              -MMD)

# Create a version header file
configure_file(${PROJECT_SOURCE_DIR}/cmake/templates/version.h.in
               ${PROJECT_BINARY_DIR}/generated/include/${PROJECT_NAME}/version.h)

# Add external sources
include(${PROJECT_SOURCE_DIR}/cmake/ArduinoDueCore.cmake)
include(${PROJECT_SOURCE_DIR}/cmake/LittleFS.cmake)

# Add subdirectories
add_subdirectory(lib)
add_subdirectory(src/dummy_module)
add_subdirectory(app)

# Define path to output folder
set(CMAKE_INSTALL_PREFIX ${PROJECT_SOURCE_DIR}/output/${CMAKE_BUILD_TYPE})

# Move executable file into the /bin folder
install(TARGETS ${EXE_NAME} DESTINATION bin)
install(FILES $<TARGET_FILE_DIR:${EXE_NAME}>/${EXE_NAME}.bin DESTINATION bin)
install(FILES $<TARGET_FILE_DIR:${EXE_NAME}>/${EXE_NAME}.hex DESTINATION bin)

# Move API files into the /include folder
file(MAKE_DIRECTORY ${PROJECT_SOURCE_DIR}/include/${PROJECT_NAME})
install(DIRECTORY ${PROJECT_SOURCE_DIR}/include/${PROJECT_NAME} DESTINATION include)

# Ensure required utilities are installed
include(${PROJECT_SOURCE_DIR}/cmake/SetupUtility.cmake)
install_utility("clang-format")
install_utility("clang-tidy")
install_utility("cmake-format")

# Add clang-format support
include(${PROJECT_SOURCE_DIR}/cmake/ClangFormat.cmake)
add_clang_format_target()

# Add clang-tidy support
include(${PROJECT_SOURCE_DIR}/cmake/ClangTidy.cmake)
add_clang_tidy_target()

# Add cmake-format support
include(${PROJECT_SOURCE_DIR}/cmake/CMakeFormat.cmake)
add_cmake_format_target()

# Add cmake-lint support
include(${PROJECT_SOURCE_DIR}/cmake/CMakeLint.cmake)
add_cmake_lint_target()
