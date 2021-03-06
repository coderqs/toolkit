cmake_minimum_required(VERSION 3.0)

# build target
if (NOT DEFINED BUILD_EXECUTABLE)
    option(BUILD_SHARED_LIBS "" ON)
    message("default build shared librarys.")
else()
    option(BUILD_EXECUTABLE "" ON)
    message("build executable.")
endif() 

if (NOT DEFINED TARGET_PLATFORM)
    set(TARGET_PLATFORM "linux")
    message(WARNING "not target platform specified, default set is \"linux\"")
endif()

# build type
if (CMAKE_BUILD_TYPE STREQUAL "")
    set(CMAKE_BUILD_TYPE "Release")
endif()
if(CMAKE_BUILD_TYPE AND (CMAKE_BUILD_TYPE STREQUAL "Debug"))
    set(CMAKE_C_FLAGS_DEBUG "${CMAKE_C_FLAGS} -Wall -O0 -fsanitize=address")
    message(STATUS "Debug mode:${CMAKE_C_FLAGS_DEBUG}")
elseif(CMAKE_BUILD_TYPE AND (CMAKE_BUILD_TYPE STREQUAL "Release"))
    set(CMAKE_C_FLAGS_RELEASE "${CMAKE_C_FLAGS} -Wall -O3")
    message(STATUS "Release mode:${CMAKE_C_FLAGS_RELEASE}")
else()
    message(STATUS "CMAKE_BUILD_TYPE:${CMAKE_BUILD_TYPE}")
    message(STATUS "CMAKE_C_FLAGS:${CMAKE_C_FLAGS}")
endif()

