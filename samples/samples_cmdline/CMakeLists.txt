cmake_minimum_required(VERSION 3.0)

project(samples_cmdline)

include(${CMAKE_SOURCE_DIR}/cmake/generate_version_file.cmake)

set(PROJECT_SOURCE 
    samples_cmdline.cpp
)

include_directories(${CMAKE_SOURCE_DIR}/toolkit)

add_executable(samples_cmdline ${PROJECT_SOURCE})