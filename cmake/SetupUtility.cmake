# Check if a utility exists in the system
# Usage: check_utility_exists(<utility_name>)
function(check_utility_exists utility_name)

    unset(UTILITY_EXE CACHE)
    find_program(UTILITY_EXE NAMES ${utility_name})
    if(NOT UTILITY_EXE)
        message(
            FATAL_ERROR
                "${utility_name} not found! Please install ${utility_name} before proceeding.")
    endif()

endfunction()

# Install a utility if it is not found
# Usage: install_utility(<utility_name>)
function(install_utility utility_name)

    # Install if utility is not found
    unset(UTILITY_EXE CACHE)
    find_program(UTILITY_EXE ${utility_name})
    if(NOT UTILITY_EXE)
        message(WARNING "${utility_name} not found! Try installing ${utility_name}...")

        if(UNIX AND NOT APPLE)
            execute_process(
                COMMAND bash -c "sudo apt-get update -qq && sudo apt-get install -y ${utility_name}"
                RESULT_VARIABLE INSTALL_RESULT)
        elseif(APPLE)
            execute_process(COMMAND bash -c "brew install ${utility_name}"
                            RESULT_VARIABLE INSTALL_RESULT)
        elseif(WIN32)
            message(FATAL_ERROR "${utility_name} not found. Please install it manually.")
        endif()

        if(NOT INSTALL_RESULT EQUAL 0)
            message(FATAL_ERROR "${utility_name} could not be installed automatically.")
        endif()

        # Check success of installation
        unset(UTILITY_EXE CACHE)
        find_program(UTILITY_EXE NAMES ${utility_name})
        if(NOT UTILITY_EXE)
            message(FATAL_ERROR "${utility_name} not found after installation.")
        endif()
    endif()

endfunction()
