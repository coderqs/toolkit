cmake_minimum_required(VERSION 3.0)

project(sample_generated_version_file)

include(${CMAKE_SOURCE_DIR}/cmake/generate_version_file.cmake)

#include_directories(${CMAKE_SOURCE_DIR})
add_executable(sample_generated_version_file sample_generated_version_file.cpp)