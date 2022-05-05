cmake_minimum_required(VERSION 3.0)

project(sample_design_pattern)

aux_source_directory(${CMAKE_SOURCE_DIR}/samples/design_pattern PROJEST_SOURCES)
message(status ${PROJEST_SOURCES})

include_directories(${CMAKE_SOURCE_DIR}/toolkit)
add_executable(${PROJECT_NAME} ${PROJEST_SOURCES} )
