# Add a target to lint all CMake files using cmake-lint
# BUG: cmake-lint is just linting the first file passed to it. Need to find a workaround.
function(add_cmake_lint_target)

    # Stop if cmake-format is not installed
    check_utility_exists("cmake-format")
    find_program(CMAKE_LINT_EXE NAMES "cmake-lint")

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

    # Prepare report path
    set(report_path "${PROJECT_SOURCE_DIR}/docs/reports")

    # Construct the cmake-lint command
    set(cmake_lint_cmd "${CMAKE_LINT_EXE} ${ALL_CMAKE_SOURCES}")

    # Create custom target and run CMake script
    add_custom_target(
        report-cmake-lint
        COMMAND ${CMAKE_COMMAND} -P ${PROJECT_SOURCE_DIR}/cmake/ReportUtility.cmake -- "cmake-lint"
                "${PROJECT_BINARY_DIR}" "${report_path}" "${cmake_lint_cmd}"
        WORKING_DIRECTORY "${PROJECT_SOURCE_DIR}"
        USES_TERMINAL
        COMMENT "CMake-lint is reporting coding violations."
        VERBATIM)

endfunction()
