cmake_minimum_required(VERSION 3.0)

project(sample_generated_version_file)

include(${CMAKE_SOURCE_DIR}/cmake/generate_version_file.cmake)

set(PROJECT_SOURCE 
    sample_generated_version_file.cpp
)

include_directories(${CMAKE_SOURCE_DIR})
include_directories(${CMAKE_SOURCE_DIR}/toolkit)

add_executable(${PROJECT_NAME} ${PROJECT_SOURCE})