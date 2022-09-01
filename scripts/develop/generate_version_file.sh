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
source_path="${2:-"../../src"}"
version_file="../../VERSION"
need_version_cpp="${3:-1}"

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
    _version=
    if [ -z ${program_version_build} ];then
        _version="${program_version_major}.${program_version_minor}.${program_version_patch}"
    else
        if [ -z ${program_version_revision} ];then
            _version="${program_version_major}.${program_version_minor}.${program_version_patch}.${program_version_build}"
        else
            _version="${program_version_major}.${program_version_minor}.${program_version_patch}.${program_version_build}.${program_version_revision}"
        fi
    fi
    echo "version: ${_version}"
}

function GetVersion(){
    if [ ! -e "${version_file}" ]; then
        echo "not found file ${version_file}"
        exit 1
    fi

    declare `grep MAJOR ${version_file}` 
    program_version_major=${MAJOR}
    declare `grep MINOR ${version_file}` 
    program_version_minor=${MINOR}
    declare `grep PATCH ${version_file}` 
    program_version_patch=${PATCH}
    declare `grep BUILD ${version_file}` 
    program_version_build=${BUILD}
    declare `grep REVISION ${version_file}` 
    program_version_revision=${REVISION}
}

function GenerateVersionHeadFile(){
    file_version_h=${source_path}/version.h
    cp ${script_dir}/../../version.h.in ${file_version_h}   

    GetVersion 

    upper_project_name=`printf '%s' "${project_name^^}"`
    echo "${upper_project_name}"

    sed -i "s/@UPPERCASE_PROJECT_NAME@/${upper_project_name}/g" ${file_version_h}
    sed -i "s/@PROJECT_NAME@/${project_name}/g" ${file_version_h}
    sed -i "s/@REPOSITORY@/${repository}/g" ${file_version_h}
    sed -i "s/@REVISION_NUM@/${revision_num}/g" ${file_version_h}
    sed -i "s/@VERSION_MAJOR@/${program_version_major}/g" ${file_version_h}
    sed -i "s/@VERSION_MINOR@/${program_version_minor}/g" ${file_version_h}
    sed -i "s/@VERSION_PATCH@/${program_version_patch}/g" ${file_version_h}
    sed -i "s/@VERSION_BUILD@/${program_version_build}/g" ${file_version_h}
    sed -i "s/@VERSION_REVISION@/${program_version_revision}/g" ${file_version_h}
}

function GenerateVersionCppFile(){
    file_version_cpp=${source_path}/version.cpp
    cp ${script_dir}/../../library_main.cpp ${file_version_cpp}    
}

function main() {
    GenerateVersionHeadFile

    if [ $need_version_cpp ];then
        GenerateVersionCppFile
    fi

    ShwoInfo
}

main