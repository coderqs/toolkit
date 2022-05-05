cmake_minimum_required(VERSION 3.0)

project(toolkit CXX)

include(${CMAKE_SOURCE_DIR}/cmake/generate_version_file.cmake)

set(PROJECT_SOURCE 
    library_show_version.cpp
    main.cpp
)

include_directories(${CMAKE_SOURCE_DIR}/include)
link_directories(${CMAKE_SOURCE_DIR}/lib)

add_library(toolkit STATIC ${PROJECT_SOURCE})


