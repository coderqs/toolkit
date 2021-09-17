
include(cmake/get_git_info.cmake)

set(VERSION_FILE "version.h")

# message(STATUS "Generate ${VERSION_FILE} file")
string(TOUPPER ${PROJECT_NAME} UPPERCASE_PROJECT_NAME)

configure_file(./version.h.in ${CMAKE_SOURCE_DIR}/version.h @ONLY NEWLINE_STYLE LF)
message(STATUS "Generate file to ${CMAKE_SOURCE_DIR}/version.h")
