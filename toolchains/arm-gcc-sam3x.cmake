# =========================================================
# Toolchain file for Arduino Due (SAM3X8E, Cortex-M3)
# =========================================================
set(CMAKE_SYSTEM_NAME Generic)
set(CMAKE_SYSTEM_VERSION 1)
set(CMAKE_SYSTEM_PROCESSOR arm)

# ---- Compiler prefix (cross toolchain) ----
set(ARM_GCC_PREFIX arm-none-eabi)
set(CMAKE_C_COMPILER   ${ARM_GCC_PREFIX}-gcc)
set(CMAKE_CXX_COMPILER ${ARM_GCC_PREFIX}-g++)
set(CMAKE_ASM_COMPILER ${ARM_GCC_PREFIX}-gcc)
set(CMAKE_AR           ${ARM_GCC_PREFIX}-ar)
set(CMAKE_OBJCOPY      ${ARM_GCC_PREFIX}-objcopy)
set(CMAKE_OBJDUMP      ${ARM_GCC_PREFIX}-objdump)
set(CMAKE_SIZE         ${ARM_GCC_PREFIX}-size)

# ---- No host test builds ----
set(CMAKE_TRY_COMPILE_TARGET_TYPE STATIC_LIBRARY)

# ---- CPU/ABI settings ----
set(CPU_FLAGS "-mcpu=cortex-m3 -mthumb")

set(CMAKE_C_FLAGS_INIT
    "${CPU_FLAGS} -ffunction-sections -fdata-sections")
set(CMAKE_CXX_FLAGS_INIT
    "${CPU_FLAGS} -fno-exceptions -fno-rtti -ffunction-sections -fdata-sections -fno-threadsafe-statics")
set(CMAKE_EXE_LINKER_FLAGS_INIT
    "${CPU_FLAGS} -Wl,--gc-sections")   # Remove unused sections when linking

# ---- Optional: Programmer / Tools ----
find_program(BOSSAC_EXE bossac)
if (NOT BOSSAC_EXE)
    message(WARNING "bossac not found — flashing will be disabled")
endif()

# ---- Export path to make available in main CMake ----
set(TOOLCHAIN_CPU_FLAGS "${CPU_FLAGS}" CACHE STRING "CPU flags for SAM3X8E")
set(TOOLCHAIN_PREFIX "${ARM_GCC_PREFIX}" CACHE STRING "Toolchain prefix")
