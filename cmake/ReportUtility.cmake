# This CMake script runs a specified code analysis utility (e.g., clang-tidy) and generates a
# report.
# Usage: cmake -P ReportUtility.cmake -- <UTILITY_NAME> <BUILD_DIR> <REPORT_PATH> <UTILITY_CMD>
if(CMAKE_ARGC LESS 8)
    message(
        FATAL_ERROR
            "Usage: cmake -P ReportUtility.cmake -- <UTILITY_NAME> <BUILD_DIR> <REPORT_PATH> "
            "<UTILITY_CMD>")
endif()

# Assign arguments to variables
set(UTILITY_NAME "${CMAKE_ARGV4}")
set(BUILD_DIR "${CMAKE_ARGV5}")
set(REPORT_PATH "${CMAKE_ARGV6}")
set(UTILITY_CMD "${CMAKE_ARGV7}")

# Check if compile_commands.json exists
if(UTILITY_NAME STREQUAL "clang-tidy")

    if(NOT EXISTS "${BUILD_DIR}/compile_commands.json")
        message(FATAL_ERROR "compile_commands.json not found in ${BUILD_DIR}.\n"
                            "Add 'set(CMAKE_EXPORT_COMPILE_COMMANDS ON)' to your CMakeLists.txt")
    endif()

endif()

# Prepare report path and filename
string(TIMESTAMP CURRENT_TIME "%Y%m%d-%H%M%S")
set(REPORT_FILE_PATH "${REPORT_PATH}/${UTILITY_NAME}")
set(REPORT_FILE "${REPORT_FILE_PATH}/${CURRENT_TIME}-${UTILITY_NAME}.txt")

# Run utility command
execute_process(
    COMMAND ${CMAKE_COMMAND} -E make_directory "${REPORT_FILE_PATH}"
    COMMAND ${CMAKE_COMMAND} -E remove -f "${REPORT_FILE}"
    COMMAND bash -lc ${UTILITY_CMD}
    WORKING_DIRECTORY "${BUILD_DIR}"
    RESULT_VARIABLE RES
    OUTPUT_VARIABLE OUT
    ERROR_VARIABLE ERR)

# Create report
file(WRITE "${REPORT_FILE}" "=== ${UTILITY_NAME} output ===\n\n")
file(APPEND "${REPORT_FILE}" "${OUT}\n")
if(NOT "${ERR}" STREQUAL "")
    file(APPEND "${REPORT_FILE}" "\n=== STDERR ===\n${ERR}\n")

    # Display message if issues were found
    message(WARNING "${UTILITY_NAME} reported issues. See: ${REPORT_FILE}")
endif()
