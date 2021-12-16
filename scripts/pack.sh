#!/bin/bash
program_version="$1" # 输出的程序的版本号
os_type="${2:-"linux"}"
arch_type="${3:-"x64"}"
optim="${4:-"release"}"

# 项目名称，输出的程序名、头文件目录都要和这个名字一致
project_name=""
#project_root=..
output_path="../out"
use_std_dir_struct=true

# ----------------------------
outpath_bin=
outpath_lib=
outpath_inc=
outpath_symbol=
outpath_conf=
outpath_doc=

program_path_bin=
program_path_lib=
program_path_inc=
program_path_symbol=
program_path_conf=
program_path_doc=

program_ext_exe=
program_ext_static_lib=
program_ext_shared_lib=
program_ext_symbol=
# ----------------------------


function CreateOutDirStruct(){
    _outpath="$1"
    
    mkdir -p "${_outpath}"/{binary,library,include,pdb,config,doc}

    outpath_bin=${_outpath}/binary
    outpath_lib=${_outpath}/library
    outpath_inc=${_outpath}/include
    outpath_symbol=${_outpath}/pdb
    outpath_conf=${_outpath}/config
    outpath_doc=${_outpath}/doc
    return 0
}

function GenerateFullVersionNum(){
    _build_date=$(date "+%Y%m%d_%H%M") # 编译版本号使用编译时间
    echo "${program_version}.${_build_date}"
    return 0
}

function GeneratePackageName(){
    _version="$1"
    echo "${project_name}-${_version}-${os_type}_${arch_type}_${optim}"
    return 0
}

function CreateZipPack(){
    if ! type zip >/dev/null 2>&1; then
        echo "zip 未安装，不执行压缩操作";
        return 1
    fi
    _package_name="$1"
    zip -qr "${_package_name}.zip" "${_package_name}"
    return 0
}

function Strcmp(){
    str1=$1
    str2=$2
    if echo "$str1" | grep -qwi "$str2"; then
        return 0
    else
        return 1
    fi        
}

function ShowEnvInfo(){
    echo "program_path_bin=${program_path_bin}"
    echo "program_path_lib=${program_path_lib}"
    echo "program_path_inc=${program_path_inc}"
    echo "program_path_symbol=${program_path_symbol}"
    echo "program_path_conf=${program_path_conf}"
    echo "program_path_doc=${program_path_doc}"
}

function LinuxOSPackEnvSet(){
    echo "set linux pack env"
    if ${use_std_dir_struct}; then
        program_path_bin=../builds/linux/build/
        program_path_lib=${program_path_bin}
        program_path_inc=../include
        program_path_symbol=${program_path_bin}
        program_path_conf=../config
        program_path_doc=../doc
        
        program_ext_exe=
        program_ext_static_lib=".a"
        program_ext_shared_lib=".so"
        program_ext_symbol=
    fi
    ShowEnvInfo
}

function WindwosOSPackEnvSet(){
    echo "set windows pack env"
    if ${use_std_dir_struct}; then
        program_path_bin=../bin
        program_path_lib=${program_path_bin}
        program_path_inc=../include
        program_path_symbol=${program_path_bin}
        program_path_conf=../config
        program_path_doc=../doc
        
        program_ext_exe=".exe"
        program_ext_static_lib=".lib"
        program_ext_shared_lib=".dll"
        program_ext_symbol=".pdb"
    fi
    ShowEnvInfo
}

function AndroidOSPackEnvSet(){
    echo "set android pack env"
    if ${use_std_dir_struct}; then
        _arch=
        if [ "${arch_type}" = "x64" ]; then
            _arch="armv8"
        else
            _arch="armeabi"
        fi

        program_path_bin=../builds/android/libs/${_arch}
        program_path_lib=${program_path_bin}
        program_path_inc=../include
        program_path_symbol=../builds/android/objs/${_arch}
        program_path_conf=../config
        program_path_doc=../doc
        
        program_ext_exe=
        program_ext_static_lib=".a"
        program_ext_shared_lib=".so"
        program_ext_symbol=
    fi
    ShowEnvInfo
}

function IsWindwos(){
    Strcmp "windows" "${os_type}"
    return $?
}

function IsLinux(){
    if Strcmp "centos" "${os_type}"; then
        return 0
    fi
    if Strcmp "ubuntu" "${os_type}"; then
        return 0
    fi
    if Strcmp "redhat" "${os_type}"; then
        return 0
    fi
    return 1
}

function IsAndroid(){
    Strcmp "android" "${os_type}"
    return $?
}

function InitPackEnv(){
    if IsWindwos; then
        WindwosOSPackEnvSet
        return 0
    fi
    
    if IsLinux; then
        LinuxOSPackEnvSet
        return 0
    fi

    if IsAndroid; then
        AndroidOSPackEnvSet
    fi
    return 1
}

function CopyFiles(){
    InitPackEnv 

    cp ${program_path_bin}/"${project_name}"."${program_ext_exe}" "${outpath_bin}" >/dev/null 2>&1
    cp ${program_path_bin}/"${project_name}"."${program_ext_shared_lib}"* "${outpath_bin}" >/dev/null 2>&1
    cp ${program_path_lib}/"${project_name}"."${program_ext_shared_lib}"* "${outpath_lib}" >/dev/null 2>&1
    cp ${program_path_lib}/"${project_name}"."${program_ext_static_lib}"* "${outpath_lib}" >/dev/null 2>&1
    if [[ ${os_type} = "windows" ]]; then                              
        cp ${program_path_symbol}/"${project_name}"."${program_ext_symbol}" "${outpath_symbol}"
    elif [[ ${os_type} = "android" ]]; then
        cp ${program_path_symbol}/"${project_name}"."${program_ext_static_lib}" "${outpath_symbol}" >/dev/null 2>&1
        cp ${program_path_symbol}/"${project_name}"."${program_ext_shared_lib}" "${outpath_symbol}" >/dev/null 2>&1
    fi
    cp ${program_path_conf}/* "${outpath_conf}"
    cp ${program_path_doc}/* "${outpath_doc}"
    cp -R ${program_path_inc}/"${project_name}" "${outpath_inc}"
}

function main(){
    version=$(GenerateFullVersionNum)
    package_name=$(GeneratePackageName "${version}")
    CreateOutDirStruct ${output_path}/"${package_name}"
    CopyFiles
    cd ${output_path} || echo "cd ${output_path} fail! not pack zip"
    CreateZipPack "${package_name}"
}

main
