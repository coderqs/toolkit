
set(VERSION_FILE "version.h")

message(STATUS "generate ${VERSION_FILE} file")
string(TOUPPER ${PROJECT_NAME} UPPERCASE_PROJECT_NAME)

if (NOT DEFINED ${MANAGED_PLATFORM})
    set(MANAGED_PLATFORM, "")
    set(MANAGED_PLATFORM_VERSION, "")
    set(REVISION_NUM "")
    set(REPOSITORY "")
endif()

configure_file(../version.h.in ${CMAKE_SOURCE_DIR}/../version.h @ONLY NEWLINE_STYLE LF)

