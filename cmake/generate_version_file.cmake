
include(get_git_info)

string(TOUPPER ${PROJECT_NAME} UPPERCASE_PROJECT_NAME)

# read VERSION file 
file(READ ${CMAKE_SOURCE_DIR}/VERSION version_file)
string(REGEX MATCH "MAJOR=[0-9]+" VERSION_MAJOR ${version_file})
string(REGEX MATCH "MINOR=[0-9]+" VERSION_MINOR ${version_file})
string(REGEX MATCH "PATCH=[0-9]+" VERSION_PATCH ${version_file})
#string(REGEX MATCH "BUILD=[0-9]+" VERSION_BUILD ${version_file})
#string(REGEX MATCH "REVISION=[0-9]+" VERSION_REVISION ${version_file})
message(STATUS "${PROJECT_NAME} version=[${VERSION_MAJOR}.${VERSION_MINOR}.${VERSION_PATCH}]")

configure_file(${CMAKE_SOURCE_DIR}/version.h.in ${CMAKE_SOURCE_DIR}/version.h @ONLY NEWLINE_STYLE LF)
message(STATUS "Generate file to ${CMAKE_SOURCE_DIR}/version.h")
