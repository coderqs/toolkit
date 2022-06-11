cmake_minimum_required(VERSION 3.2)

set(CMAKE_MODULE_PATH "${CMAKE_CURRENT_SOURCE_DIR}/cmake;${CMAKE_MODULE_PATH}")

include(common_base_setting)

project(toolkit CXX)

set(OPERATING_SYSTEM "${CMAKE_SYSTEM_NAME}")
set(OS "\"${CMAKE_SYSTEM_NAME}\"")

if (NOT DEFINED PROGRAM_TARGET_NAME)
    set(PROGRAM_TARGET_NAME ${PROJECT_NAME})
endif()
message(STATUS "program target name: ${PROGRAM_TARGET_NAME}")

include_directories(${CURL_SOURCE_DIR})
include_directories(${CURL_SOURCE_DIR}/include)
include_directories(${CURL_SOURCE_DIR}/src)

#if(CMAKE_COMPILER_IS_GNUCC OR CMAKE_COMPILER_IS_CLANG)
#  if(PICKY_COMPILER)
#    foreach(_CCOPT -pedantic -Wall -W -Wpointer-arith -Wwrite-strings -Wunused -Wshadow -Winline -Wnested-externs -Wmissing-declarations -Wmissing-prototypes -Wfloat-equal -Wsign-compare -Wundef -Wendif-labels -Wstrict-prototypes -Wdeclaration-after-statement -Wstrict-aliasing=3 -Wcast-align -Wtype-limits -Wold-style-declaration -Wmissing-parameter-type -Wempty-body -Wclobbered -Wignored-qualifiers -Wconversion -Wvla -Wdouble-promotion)
#      # surprisingly, CHECK_C_COMPILER_FLAG needs a new variable to store each new
#      # test result in.
#      string(MAKE_C_IDENTIFIER "OPT${_CCOPT}" _optvarname)
#      check_c_compiler_flag(${_CCOPT} ${_optvarname})
#      if(${_optvarname})
#        set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} ${_CCOPT}")
#      endif()
#    endforeach()
#    foreach(_CCOPT long-long multichar format-nonliteral sign-conversion system-headers pedantic-ms-format)
#      # GCC only warns about unknown -Wno- options if there are also other diagnostic messages,
#      # so test for the positive form instead
#      string(MAKE_C_IDENTIFIER "OPT${_CCOPT}" _optvarname)
#      check_c_compiler_flag("-W${_CCOPT}" ${_optvarname})
#      if(${_optvarname})
#        set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -Wno-${_CCOPT}")
#      endif()
#    endforeach()
#  endif()
#endif()

include(generate_version_file)
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

set(LINK_LIB_LIST "")

## link library list
if (TARGET_PLATFORM AND (TARGET_PLATFORM STREQUAL ""))
    set(LINK_LIB_LIST 
        
    )
    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -w -Wno-invalid-offsetof -fvisibility=hidden --no-gnu-unique")
    
elseif (TARGET_PLATFORM AND (TARGET_PLATFORM STREQUAL ""))
    set(LINK_LIB_LIST 
        
    )
    
else()
    set(LINK_LIB_LIST 
        
    )
    
endif()

## source code
aux_source_directory("${CMAKE_CURRENT_SOURCE_DIR}/src" PROJEST_SOURCES)
### other methods
# set(PROJEST_SOURCES 
#   enumerate the files here
#   ) 
message(STATUS, ${PROJEST_SOURCES})

## compile option
set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -g -pthread -Wl,-rpath=.") # -Wl,-Bsymbolic -Wno-invalid-offsetof -fvisibility=hidden --no-gnu-unique -fsanitize=address
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++11")

if (BUILD_EXECUTABLE)
    set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS}")
    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS}")
    
    add_executable(${PROGRAM_TARGET_NAME} ${PROJEST_SOURCES})
else() 
    if (BUILD_SHARED_LIBS)
        set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -fPIC")
        set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS}")
        add_library(${PROGRAM_TARGET_NAME} SHARED ${PROJEST_SOURCES})
        
    else()
        set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS}")
        set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS}")
        add_library(${PROGRAM_TARGET_NAME} STATIC ${PROJEST_SOURCES})
        
    endif() # if (BUILD_SHARED_LIBS)
endif() # if (BUILD_EXECUTABLE)

message(STATUS "CMAKE_C_FLAGS: ${CMAKE_C_FLAGS}")
message(STATUS "CMAKE_CXX_FLAGS: ${CMAKE_CXX_FLAGS}")

target_link_libraries(${PROGRAM_TARGET_NAME} ${LINK_LIB_LIST})

## install
install(TARGETS ${PROGRAM_TARGET_NAME}
        LIBRARY DESTINATION lib  # shared library install path
        ARCHIVE DESTINATION lib  # static library install path
        RUNTIME DESTINATION bin  # executable program install path
        PUBLIC_HEADER DESTINATION include    # header files install path
        )
