#!/bin/bash
# 用于非 CMake 工程生成 version.h 和 version.cpp 文件
# 版本信息默认从 VERSION 文件中获取
#

set -e

script_abs=$(readlink -f "$0")
script_dir=$(dirname $script_abs)
cd ${script_dir}

project_name="${1:-""}"
project_name=$(echo ${project_name} | tr 'a-z' 'A-Z')
source_path="${2:-""}"
version_file="../VERSION"

revision_num=
repository=
if  $(git --version); then
    revision_num=$(git rev-parse --short=8 HEAD)
    repository="Git"
elif  $(svn --version); then
    revision_num=$(svnversion)
    repository="Svn"
else 
    revision_num=""
    repository=""
fi

program_version_major=
program_version_minor=
program_version_patch=
program_version_build=
program_version_revision=

function ShwoInfo(){
    echo "project_name: ${project_name}"
    echo "repository: ${repository} revision_num: ${revision_num}"
    echo "version: ${program_version_major}.${program_version_minor}.${program_version_patch}.${program_version_build}.${program_version_revision}"
}

function GetVersion(){
    if [ -e "${version_file}" ]; then
        echo "not found file ${version_file}"
        exit 1
    fi

    declare `grep MAJOR ${version_file}` 
    program_version_major=${MAJOR}
    declare `grep MINOR ${version_file}` 
    program_version_minor=${MINOR}
    declare `grep PATCH ${version_file}` 
    program_version_patch=${PATCH}
}

function GenerateVersionHeadFile(){
    file_version_h=${source_path}/version.h

    GetVersion 

    cat>"${file_version_h}"<<EOF
#ifndef ${project_name}__VERSION_H_
#define ${project_name}__VERSION_H_

#define PROGRAM_NAME "${project_name}"
#define REPOSITORY "${repository}"
#define REVISION_NUM "${revision_num}"

#define PROGRAM_VERSION_MAJOR "${program_version_major}" 
#define PROGRAM_VERSION_MINOR "${program_version_minor}"  
#define PROGRAM_VERSION_PATCH "${program_version_patch}"

#endif // ${project_name}__VERSION_H_
EOF
}

function GenerateVersionCppFile(){
    file_version_cpp=${source_path}/version.cpp

    GenerateVersionHeadFile

    cat>"${file_version_cpp}"<<EOF
#include "version.h" 
#ifdef __linux__
#ifdef __x86_64__
const char interp[] __attribute__((section(".interp"))) = "/lib64/ld-linux-x86-64.so.2";
#else
const char interp[] __attribute__((section(".interp"))) = "/lib/ld-linux.so.2";
#endif // __x86_64__
#include <unistd.h>

static const char banner[] =
PROGRAM_NAME " " PROGRAM_VERSION_MAJOR "." PROGRAM_VERSION_MINOR "." PROGRAM_VERSION_PATCH "\n" \\
"Build in " __DATE__ __TIME__ " (for Linux platform)\n" \\
"Managed on " REPOSITORY " revision num: " REVISION_NUM "\n" \\
"Copyright (C) all rights reserved \n";

extern void __libc_print_version (void); 
void __libc_print_version (void) {
  write (STDOUT_FILENO, banner, sizeof banner - 1);
}

/* This function is the entry point for the shared object. 
   Running the library as a program will get here.  */

extern void __libc_main (void) __attribute__ ((noreturn));
void __libc_main (void) {
  __libc_print_version ();
  _exit (0);
}

#endif // __linux__
EOF
}

function main() {
    GenerateVersionCppFile
    ShwoInfo
}

main