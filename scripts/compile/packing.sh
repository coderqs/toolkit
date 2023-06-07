#!/bin/bash
# input:
#   $1  目标操作系统的类型
#   $2  目标操作系统的架构类型
#   $3  发布类型
#   $4  程序的版本文件
#   $5  打包的配置文件
#
# return
#   1   加载打包的配置文件失败
#   2   配置文件中没有找到对应的目标操作系统的配置
#   3   没有安装  zip，不执行压缩动作
#   4   没有输入目标操作系统

#set -e
SHELL_FOLDER=$(cd "$(dirname "$0")";pwd)

#source ${SHELL_FOLDER}/../general/clog_print.sh

os_type="${1:-""}"
arch_type="${2:-"x64"}"
optim="${3:-"release"}"
program_version="${4:-""}"
program_config="${5:-"packing.yaml"}"

if [ -z os_type ]; then
    echo "[ERROR] os_type can't be empty!"
    exit 4
fi

outpath_bin=
outpath_lib=
outpath_inc=
outpath_symbol=
outpath_conf=
outpath_doc=

function LoadYamlScript() {
    source ${SHELL_FOLDER}/../../3rdparty/bash-yaml/script/yaml.sh
    if [ ! $? ];then 
        wget https://raw.githubusercontent.com/jasperes/bash-yaml/master/script/yaml.sh
        source yaml.sh
        if [ $? ];then
            echo "[Error] load yaml script failure!" && exit 1 
        fi
    fi
}

function ReadConfig() {
    LoadYamlScript
    parse_yaml "${program_config}" >/dev/null 2>&1
    create_variables "${program_config}"
    
    # variable name list
    ## project_name
    ## version_file
    ## output_path
    ## program_name
    ## program_type
    ## pack_info_os_${os_type}_src_binrary_path 
    ## pack_info_os_${os_type}_src_library_path 
    ## pack_info_os_${os_type}_src_include_path 
    ## pack_info_os_${os_type}_src_symbol_path
    ## pack_info_os_${os_type}_src_config_path
    ## pack_info_os_${os_type}_src_doc_path
    ## pack_info_os_${os_type}_src_binrary_path[*]
    ## pack_info_os_${os_type}_src_library_path[*]
    ## pack_info_os_${os_type}_src_include_path[*]
    ## pack_info_os_${os_type}_src_symbol_path[*]
    ## pack_info_os_${os_type}_src_config_path[*]
    ## pack_info_os_${os_type}_src_doc_path[*]
}
function ReadVersion() {
    if [ -e "${version_file}" ]; then
        for line in $(cat ${version_file}); do
            eval "${line}"
        done
        program_version="${MAJOR}.${MINOR}.${PATCH}"
        echo "${program_version}"
    else
        echo "[Error] \"VERSION\" file not exist!"
    fi 
}
function GenerateFullVersionNum() {
    _build_date=$(date "+%Y%m%d_%H%M") # 编译版本号使用编译时间
    echo "${program_version}.${_build_date}"
    return 0
}
function GeneratePackageName() {
    _version="$1"
    echo "${project_name}-${_version}-${os_type}_${arch_type}_${optim}"
    return 0
}
function CreateOutDirStruct() {
    _outpath="$1"
    echo "CreateOutDirStruct ${_outpath}"
    
    mkdir -p "${_outpath}"/{binary,library,include,pdb,config,doc}

    outpath_bin=${_outpath}/binary
    outpath_lib=${_outpath}/library
    outpath_inc=${_outpath}/include
    outpath_symbol=${_outpath}/pdb
    outpath_conf=${_outpath}/config
    outpath_doc=${_outpath}/doc

    return 0
}
function CheckOsConfig() {
    _os_name="pack_info_os_${os_type}_name"
    if [ -z ${!_os_name+x} ];then
        echo "[Error] No ${os_type} corresponding configuration is available"
        exit 2
    fi
    return 0
}
function CopyFiles() {
    _conf_full_path=$(cd "$(dirname "${program_config}")";pwd)
    
    CheckOsConfig

    ## pack_info_os_${os_type}_src_binrary_path 
    ## pack_info_os_${os_type}_src_library_path 
    ## pack_info_os_${os_type}_src_include_path 
    ## pack_info_os_${os_type}_src_symbol_path
    ## pack_info_os_${os_type}_src_config_path
    ## pack_info_os_${os_type}_src_doc_path
    ## pack_info_os_${os_type}_src_binrary_list[*]
    ## pack_info_os_${os_type}_src_library_list[*]
    ## pack_info_os_${os_type}_src_include_list[*]
    ## pack_info_os_${os_type}_src_symbol_list[*]
    ## pack_info_os_${os_type}_src_config_list[*]
    ## pack_info_os_${os_type}_src_doc_list[*]
    
    _path="pack_info_os_${os_type}_src_binrary_path"
    _list="pack_info_os_${os_type}_src_binrary_list[*]"
    for _file in ${!_list};do
        if [ -a "${_conf_full_path}/${!_path}/${_file}" ]; then
            cp -R "${_conf_full_path}/${!_path}/${_file}" "${outpath_bin}"
            echo "copy file form ${_conf_full_path}/${!_path}/${_file} to ${outpath_bin}"
        fi
    done
    
    _path="pack_info_os_${os_type}_src_library_path"
    _list="pack_info_os_${os_type}_src_library_list[*]"
    for _file in ${!_list};do
        if [ -a "${_conf_full_path}/${!_path}/${_file}" ]; then
            cp -R "${_conf_full_path}/${!_path}/${_file}" "${outpath_lib}"
            echo "copy file form ${_conf_full_path}/${!_path}/${_file} to ${outpath_lib}"
        fi
    done
    
    _path="pack_info_os_${os_type}_src_include_path"
    _list="pack_info_os_${os_type}_src_include_list[*]"
    for _file in ${!_list};do
        if [ -a "${_conf_full_path}/${!_path}/${_file}" ]; then
            cp -R "${_conf_full_path}/${!_path}/${_file}" "${outpath_inc}"
            echo "copy file form ${_conf_full_path}/${!_path}/${_file} to ${outpath_inc}"
        fi
    done
    
    _path="pack_info_os_${os_type}_src_symbol_path"
    _list="pack_info_os_${os_type}_src_symbol_list[*]"
    for _file in ${!_list};do
        if [ -a "${_conf_full_path}/${!_path}/${_file}" ]; then
            cp -R "${_conf_full_path}/${!_path}/${_file}" "${outpath_symbol}"
            echo "copy file from ${_conf_full_path}/${!_path}/${_file} to ${outpath_symbol}"
        fi
    done
    
    _path="pack_info_os_${os_type}_src_config_path"
    _list="pack_info_os_${os_type}_src_config_list[*]"
    for _file in ${!_list};do
        if [ -a "${_conf_full_path}/${!_path}/${_file}" ]; then
            cp -R "${_conf_full_path}/${!_path}/${_file}" "${outpath_conf}"
            echo "copy file form ${_conf_full_path}/${!_path}/${_file} to ${outpath_conf}"
        fi
    done
    
    _path="pack_info_os_${os_type}_src_doc_path"
    _list="pack_info_os_${os_type}_src_doc_list[*]"
    for _file in ${!_list};do
        if [ -a "${_conf_full_path}/${!_path}/${_file}" ]; then
            cp -R "${_conf_full_path}/${!_path}/${_file}" "${outpath_doc}"
            echo "copy file form ${_conf_full_path}/${!_path}/${_file} to ${outpath_doc}"
        fi
    done
}
function CompressFile() {
    if ! type zip >/dev/null 2>&1; then
        echo "[Error] zip uninstalled, not perform compression";
        exit 3
    fi
    _package_name="$1"
    zip -qr "${_package_name}.zip" "${output_path}"/"${_package_name}" 
    if [ $? ]; then
        echo "generate compress file ${_package_name}.zip"
    fi
    return 0
}
function ClearCache() {
    rm -rf $1
}
function main() {
    ReadConfig
    ReadVersion
    
    version=$(GenerateFullVersionNum)
    package_name=$(GeneratePackageName "${version}")
    CreateOutDirStruct "${output_path}"/"${package_name}"
    CopyFiles

    CompressFile "${package_name}"
    ClearCache "${output_path}"/"${package_name}"
}

main
