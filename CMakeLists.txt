cmake_minimum_required(VERSION 3.0)

list(APPEND CMAKE_MODULE_PATH "${CMAKE_SOURCE_DIR}/cmake")
message(STATUS "CMAKE_MODULE_PATH: ${CMAKE_MODULE_PATH}")

set(OPERATING_SYSTEM "${CMAKE_SYSTEM_NAME}")
set(OS "\"${CMAKE_SYSTEM_NAME}\"")

include(CMakeDependentOption)

cmake_dependent_option(BUILD_TESTING "Build tests"
  ON "PERL_FOUND;NOT TOOLKIT_DISABLE_TESTS"
  OFF)
if(BUILD_TESTING)
  add_subdirectory(test)
endif()

cmake_dependent_option(BUILD_TESTING "Build samples"
  ON "PERL_FOUND;NOT TOOLKIT_DISABLE_SAMPLES"
  OFF)
if(BUILD_SAMPLES)
  add_subdirectory(samples)
endif()

add_subdirectory(src)