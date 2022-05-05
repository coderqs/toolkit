cmake_minimum_required(VERSION 3.0)

project(sample_libuv)

set(PROJECT_SOURCE 
    sample_libuv.cpp
)

include_directories(${CMAKE_SOURCE_DIR})
include_directories($ENV{LIBRARYS}/include)
message($ENV{LIBRARYS}/include)

link_directories($ENV{LIBRARYS}/lib)

set(CMAKE_CXX_FLAGS "-O0 -rpath=.,$ENV{LD_LIBRARY_PATH},$ENV{LIBRARYS}/bin")

add_executable(${PROJECT_NAME} ${PROJECT_SOURCE})

target_link_libraries(${PROJECT_NAME} uv)