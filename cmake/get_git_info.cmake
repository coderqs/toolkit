
find_package(Git)
if(GIT_FOUND)
    execute_process(
        COMMAND git rev-parse --short=8 HEAD
        WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}
        OUTPUT_STRIP_TRAILING_WHITESPACE 
        RESULT_VARIABLE EXECUTE_RESULT
        OUTPUT_VARIABLE GIT_REVISION_NUM)
    if (${EXECUTE_RESULT} EQUAL 0)
        set(REVISION_NUM  ${GIT_REVISION_NUM})
        message(STATUS "Git revision num: ${REVISION_NUM}")
    else()
        message(STATUS "No commit found in Git.")
    endif()

    execute_process(
        COMMAND git remote get-url --all origin
        WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR} 
        OUTPUT_STRIP_TRAILING_WHITESPACE 
        RESULT_VARIABLE EXECUTE_RESULT
        OUTPUT_VARIABLE GIT_REPOSITORY)
    if (${EXECUTE_RESULT} EQUAL 0)
        set(REPOSITORY  ${GIT_REPOSITORY})
        message(STATUS "Git remote repository url: ${REPOSITORY}")
    else()
        message(STATUS "No remote repository url.")
    endif()

endif() # if(GIT_FOUND)