include(${PROJECT_SOURCE_DIR}/cmake/GetGitRepo.cmake)

# Get LittleFS
set(LITTLEFS_URL https://github.com/littlefs-project/littlefs.git)
set(LITTLEFS_TAG adad0fbbcf5382c20978d07f94f9c13be9041c1b) # v2.11.2
get_git_repo(littlefs ${LITTLEFS_URL} ${LITTLEFS_TAG})

# Define target
add_library(littlefs STATIC ${PROJECT_SOURCE_DIR}/external/littlefs-src/lfs_util.c
                            ${PROJECT_SOURCE_DIR}/external/littlefs-src/lfs.c)

# Link global compiler flags
target_link_libraries(littlefs PRIVATE ${PROJECT_NAME}_compiler_flags)
target_link_libraries(littlefs PRIVATE ${PROJECT_NAME}_compiler_warnings)

# Add include directories
target_include_directories(littlefs PRIVATE ${PROJECT_SOURCE_DIR}/external/littlefs-src/)
