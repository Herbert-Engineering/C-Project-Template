# List of source code files
set(APP_SOURCES "${CMAKE_CURRENT_SOURCE_DIR}/app.cpp")

# Create target called ${EXE_NAME}
add_executable(${EXE_NAME} ${APP_SOURCES})

# Link compiler flags
target_link_libraries(${EXE_NAME} PRIVATE ${PROJECT_NAME}_compiler_flags)
target_link_libraries(${EXE_NAME} PRIVATE ${PROJECT_NAME}_compiler_warnings)

# Link libraries
target_link_libraries(${EXE_NAME} PRIVATE arduino_due_core)
target_link_libraries(${EXE_NAME} PRIVATE littlefs)
target_link_libraries(${EXE_NAME} PRIVATE dummy_module)

# Add include directories
target_include_directories(${EXE_NAME} PUBLIC ${PROJECT_SOURCE_DIR}/include)
target_include_directories(${EXE_NAME} PRIVATE ${PROJECT_SOURCE_DIR}/src)
target_include_directories(${EXE_NAME} PRIVATE ${CMAKE_CURRENT_SOURCE_DIR})
target_include_directories(${EXE_NAME} PRIVATE ${PROJECT_BINARY_DIR}/generated/include)

# Linker settings
set(DUE_LD_SCRIPT
    "${SAM_CORE_DIR}/variants/${DUE_VARIANT}/linker_scripts/gcc/flash.ld"
    CACHE FILEPATH "Path to linker script")
target_link_options(
    ${EXE_NAME}
    PRIVATE
    -mcpu=cortex-m3
    -mthumb
    -Os
    -Wl,--gc-sections)
target_link_options(${EXE_NAME} PRIVATE "-T${DUE_LD_SCRIPT}")

target_link_options(
    ${EXE_NAME}
    PRIVATE
    -Wl,--cref
    -Wl,--check-sections
    -Wl,--gc-sections
    -Wl,--entry=Reset_Handler
    -Wl,--unresolved-symbols=report-all
    -Wl,--warn-common
    -Wl,--warn-section-align
    -Wl,--start-group)

target_link_directories(${EXE_NAME} PRIVATE "${SAM_CORE_DIR}/variants/${DUE_VARIANT}")
target_link_libraries(${EXE_NAME} PRIVATE libsam_sam3x8e_gcc_rel.a)

target_link_libraries(${EXE_NAME} PRIVATE c m gcc nosys)

target_link_options(${EXE_NAME} PRIVATE -Wl,--end-group)

# Create BIN and HEX files after building the ELF
add_custom_command(
    TARGET ${EXE_NAME}
    POST_BUILD
    COMMAND ${CMAKE_OBJCOPY} -O binary $<TARGET_FILE:${EXE_NAME}>
            $<TARGET_FILE_DIR:${EXE_NAME}>/${EXE_NAME}.bin
    COMMAND ${CMAKE_OBJCOPY} -O ihex $<TARGET_FILE:${EXE_NAME}>
            $<TARGET_FILE_DIR:${EXE_NAME}>/${EXE_NAME}.hex
    COMMAND ${CMAKE_SIZE} -A $<TARGET_FILE:${EXE_NAME}>
    COMMENT "Creating BIN/HEX and printing size")
