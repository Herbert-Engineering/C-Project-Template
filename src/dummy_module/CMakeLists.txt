# Module Name
set(MODULE_NAME dummy_module)

# List of source code files
set(MODULE_SOURCES dummy_module.c)

# Create target to generate a static library (*.a)
add_library(${MODULE_NAME} STATIC ${MODULE_SOURCES})

# Link compiler flags
target_link_libraries(${MODULE_NAME} PRIVATE ${PROJECT_NAME}_compiler_flags)
target_link_libraries(${MODULE_NAME} PRIVATE ${PROJECT_NAME}_compiler_warnings)

# Add include directories
target_include_directories(${MODULE_NAME} PUBLIC ${PROJECT_SOURCE_DIR}/src)
target_include_directories(${MODULE_NAME} PRIVATE ${PROJECT_SOURCE_DIR}/include)
target_include_directories(${MODULE_NAME} PRIVATE ${PROJECT_BINARY_DIR}/generated/include)
