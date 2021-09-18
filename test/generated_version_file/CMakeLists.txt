cmake_minimum_required(VERSION 3.0)

project(test_generated_version_file)

include(${CMAKE_SOURCE_DIR}/cmake/generate_version_file.cmake)

include_directories(${CMAKE_SOURCE_DIR})
add_executable(test_generated_version_file test_generated_version_file.cpp)