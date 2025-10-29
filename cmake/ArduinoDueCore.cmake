include(${PROJECT_SOURCE_DIR}/cmake/GetGitRepo.cmake)

# Get Arduino SAM BSP
set(ARDUINO_CORE_SAM_URL https://github.com/arduino/ArduinoCore-sam.git)
set(ARDUINO_CORE_SAM_TAG 790ff2c852bf159787a9966bddee4d9f55352d15) # master; 2025 10 23
get_git_repo(arduino_core_sam ${ARDUINO_CORE_SAM_URL} ${ARDUINO_CORE_SAM_TAG})

# Path to external SAM Core library
set(SAM_CORE_DIR ${PROJECT_SOURCE_DIR}/external/arduino_core_sam-src)

# Get source files
# Startup & system files
set(DUE_STARTUP "${SAM_CORE_DIR}/system/CMSIS/Device/ATMEL/sam3xa/source/gcc/startup_sam3xa.c"
                "${SAM_CORE_DIR}/system/CMSIS/Device/ATMEL/sam3xa/source/system_sam3xa.c")

# Core files
file(GLOB SAM_CORE_C "${SAM_CORE_DIR}/cores/arduino/*.c")
file(GLOB SAM_CORE_CPP "${SAM_CORE_DIR}/cores/arduino/*.cpp")
file(GLOB SAM_CORE_ASM "${SAM_CORE_DIR}/cores/arduino/*.S")
file(GLOB SAM_CORE_USB_CPP "${SAM_CORE_DIR}/cores/arduino/USB/*.cpp")

# Variant files
file(GLOB DUE_VARIANT_CPP "${SAM_CORE_DIR}/variants/${DUE_VARIANT}/*.cpp")

# Create Arduino Due Core library
add_library(
    arduino_due_core STATIC
    ${DUE_STARTUP}
    ${SAM_CORE_C}
    ${SAM_CORE_CPP}
    ${SAM_CORE_ASM}
    ${SAM_CORE_USB_CPP}
    ${DUE_VARIANT_CPP})

# Includes
target_include_directories(
    arduino_due_core SYSTEM
    PUBLIC "${SAM_CORE_DIR}/system/libsam"
           "${SAM_CORE_DIR}/system/CMSIS/CMSIS/Include"
           "${SAM_CORE_DIR}/system/CMSIS/Device/ATMEL"
           "${SAM_CORE_DIR}/cores/arduino"
           "${SAM_CORE_DIR}/variants/${DUE_VARIANT}"
           "${SAM_CORE_DIR}/system/libsam/include" # gpbr
           "${SAM_CORE_DIR}/system/CMSIS/Device/ATMEL/sam3xa/include")

# Link global compiler flags
target_link_libraries(arduino_due_core PRIVATE ${PROJECT_NAME}_compiler_flags)
target_compile_options(arduino_due_core PRIVATE -w)

# Flash-Target
find_program(BOSSAC_EXE bossac)
if(BOSSAC_EXE)
    add_custom_target(
        flash-due
        COMMAND ${BOSSAC_EXE} -e -w -v -b -R --port=${DUE_PORT}
                ${PROJECT_SOURCE_DIR}/output/${CMAKE_BUILD_TYPE}/bin/${EXE_NAME}.bin
        DEPENDS ${EXE_NAME}
        USES_TERMINAL
        COMMENT "Flashing with bossac on ${DUE_PORT}")
else()
    message(STATUS "bossac not found - 'flash' target not available.")
endif()
