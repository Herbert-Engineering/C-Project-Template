# Add a target to format all CMake files using cmake-format
function(add_cmake_format_target)

    # Stop if cmake-format is not installed
    check_utility_exists("cmake-format")
    find_program(CMAKE_FORMAT_EXE NAMES "cmake-format")

    # Gather all CMake source files
    file(
        GLOB_RECURSE
        ALL_CMAKE_SOURCES
        "${PROJECT_SOURCE_DIR}/app/CMakeLists.txt"
        "${PROJECT_SOURCE_DIR}/external/CMakeLists.txt"
        "${PROJECT_SOURCE_DIR}/lib/CMakeLists.txt"
        "${PROJECT_SOURCE_DIR}/src/CMakeLists.txt"
        "${PROJECT_SOURCE_DIR}/tests/CMakeLists.txt"
        "${PROJECT_SOURCE_DIR}/CMakeLists.txt"
        "${PROJECT_SOURCE_DIR}/cmake/*.cmake")

    # Fix format violations
    add_custom_target(
        run-cmake-format
        COMMAND "${CMAKE_FORMAT_EXE}" -i ${ALL_CMAKE_SOURCES}
        WORKING_DIRECTORY "${PROJECT_SOURCE_DIR}"
        COMMENT "CMake-format is fixing format violations.")

endfunction()
