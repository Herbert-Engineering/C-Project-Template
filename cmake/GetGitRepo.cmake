# Add a function to download a Git repository using FetchContent
# Usage: get_git_repo(<lib_name> <git_url> <git_tag>)
function(get_git_repo lib_name git_url git_tag)

    include(FetchContent)

    set(FETCHCONTENT_BASE_DIR ${PROJECT_SOURCE_DIR}/external)
    set(FETCHCONTENT_UPDATES_DISCONNECTED ON)

    # Download Git Repo
    FetchContent_Declare(
        ${lib_name}
        GIT_REPOSITORY ${git_url}
        GIT_TAG ${git_tag})
    FetchContent_MakeAvailable(${lib_name})

    if(NOT ${lib_name}_SOURCE_DIR)
        message(FATAL_ERROR "Download of ${lib_name} failed!")
    else()
        message(STATUS "Download of ${lib_name} done to ${${lib_name}_SOURCE_DIR}")
    endif()

    # Remove unused directories
    execute_process(COMMAND bash -lc "rm -r ${FETCHCONTENT_BASE_DIR}/${lib_name}-build")
    execute_process(COMMAND bash -lc "rm -r ${FETCHCONTENT_BASE_DIR}/${lib_name}-tmp")

endfunction()
