cmake_minimum_required(VERSION 3.0)

project(sample_libcurl)

set(PROJECT_SOURCE sample_libcurl.cpp)

include_directories(${CMAKE_SOURCE_DIR})
include_directories($ENV{LIBRARYS}/include)
message($ENV{LIBRARYS}/include)

link_directories($ENV{LIBRARYS}/lib)

set(CMAKE_CXX_FLAGS "-O0 -rpath=.,$ENV{LD_LIBRARY_PATH}")

add_executable(sample_libcurl ${PROJECT_SOURCE})

target_link_libraries(sample_libcurl libcurl_imp)