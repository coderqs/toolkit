cmake_minimum_required(VERSION 3.13)

include(FindSubversion)
if(Subversion_FOUND)
    Subversion_WC_INFO(${SOURCE_DIR} PROJECT_SVN)
    set(REVISION_NUM ${PROJECT_SVN_WC_REVISION})
    set(REPOSITORY ${PROJECT_SVN_WC_ROOT})
    message(STATUS "version control detailed information:")
    message(STATUS "${PROJECT_SVN_WC_INFO}");
endif() # (Subversion_FOUND)
