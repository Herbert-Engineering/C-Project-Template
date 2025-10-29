# Add a custom target to run clang-tidy and generate a report of coding violations
function(add_clang_tidy_target)

    # Stop if run-clang-tidy is not installed
    check_utility_exists("clang-tidy")
    find_program(CLANG_TIDY_EXE NAMES "run-clang-tidy")

    # Prepare report path
    set(report_path "${PROJECT_SOURCE_DIR}/docs/reports")

    # Construct the clang-tidy command
    set(clang_tidy_cmd "${CLANG_TIDY_EXE} -p ${PROJECT_BINARY_DIR}")

    # Create custom target and run CMake script
    add_custom_target(
        report-clang-tidy
        COMMAND ${CMAKE_COMMAND} -P ${PROJECT_SOURCE_DIR}/cmake/ReportUtility.cmake -- "clang-tidy"
                "${PROJECT_BINARY_DIR}" "${report_path}" "${clang_tidy_cmd}"
        WORKING_DIRECTORY "${PROJECT_SOURCE_DIR}"
        USES_TERMINAL
        COMMENT "Clang-tidy is reporting coding violations."
        VERBATIM)

endfunction()
