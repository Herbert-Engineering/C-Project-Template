# Add clang-format targets to the project to fix and report format violations
function(add_clang_format_target)

    # Stop if clang-format is not installed
    check_utility_exists("clang-format")
    set(clang_format_exe "${UTILITY_EXE}")

    # Gather all C & H source files
    file(
        GLOB_RECURSE
        ALL_C_SOURCES
        "${PROJECT_SOURCE_DIR}/app/*.[ch]"
        "${PROJECT_SOURCE_DIR}/src/*.[ch]"
        "${PROJECT_SOURCE_DIR}/include/${PRJ_NAME}/*.[ch]"
        "${PROJECT_SOURCE_DIR}/tests/*.[ch]")

    # Fix format violations
    add_custom_target(
        run-clang-format
        COMMAND "${clang_format_exe}" -i ${ALL_C_SOURCES}
        WORKING_DIRECTORY "${PROJECT_SOURCE_DIR}"
        COMMENT "Clang-format is fixing format violations.")

    # Prepare report path
    set(report_path "${PROJECT_SOURCE_DIR}/docs/reports")

    # Construct the clang-format command
    set(clang_format_cmd "${clang_format_exe} --dry-run ${ALL_C_SOURCES}")

    # Report format violations
    add_custom_target(
        report-clang-format
        COMMAND ${CMAKE_COMMAND} -P ${PROJECT_SOURCE_DIR}/cmake/ReportUtility.cmake --
                "clang-format" "${PROJECT_BINARY_DIR}" "${report_path}" "${clang_format_cmd}"
        WORKING_DIRECTORY "${PROJECT_SOURCE_DIR}"
        USES_TERMINAL
        COMMENT "Clang-format is reporting format violations."
        VERBATIM)

endfunction()
