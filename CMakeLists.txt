cmake_minimum_required(VERSION 3.18)

include($ENV{PICO_SDK_PATH}/external/pico_sdk_import.cmake)
include($ENV{PICO_SDK_PATH}/tools/CMakeLists.txt)


project(PicoRTC C CXX ASM)
#add_subdirectory(./lib)
set(CMAKE_C_STANDARD 11)
set(CMAKE_CXX_STANDARD 17)

pico_sdk_init()



add_executable (PicoRTC
	./src/main.cpp
	)

target_link_libraries(PicoRTC
	pico_stdlib

)
pico_enable_stdio_usb(PicoRTC 1)
pico_enable_stdio_uart(PicoRTC 0)


pico_add_extra_outputs(PicoRTC)
