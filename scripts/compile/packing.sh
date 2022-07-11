#!/bin/bash

set -e
SHELL_FOLDER=$(cd "$(dirname "$0")";pwd)

#source ${SHELL_FOLDER}/../general/clog_print.sh

os_type="${1:-"linux"}"
arch_type="${2:-"x64"}"
optim="${3:-"release"}"
program_version="${4:-""}"
program_config="${5:-"packing.yaml"}"

outpath_bin=
outpath_lib=
outpath_inc=
outpath_symbol=
outpath_conf=
outpath_doc=

function LoadYamlScript() {
    source ${SHELL_FOLDER}../../3rdparty/bash-yaml/script/yaml.sh
    if [ $? ];then 
        wget https://raw.githubusercontent.com/jasperes/bash-yaml/master/script/yaml.sh
        source yaml.sh
        if [ $? ];then
            echo "[Error] load yaml script failure!" && exit 1 
        fi
    fi
}

function ReadConfig() {
    LoadYamlScript
    parse_yaml "${program_config}"
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
    _os_name="pack_info_system_${os_type}_name"
    if [ -z ${${!_os_name}+x} ];then
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
        cp -R "${_conf_full_path}/${!_path}/${_file}" "${outpath_bin}"
    done
    
    _path="pack_info_os_${os_type}_src_library_path"
    _list="pack_info_os_${os_type}_src_library_list[*]"
    for _file in ${!_list};do
        cp -R "${_conf_full_path}/${!_path}/${_file}" "${outpath_lib}"
    done
    
    _path="pack_info_os_${os_type}_src_include_path"
    _list="pack_info_os_${os_type}_src_include_list[*]"
    for _file in ${!_list};do
        cp -R "${_conf_full_path}/${!_path}/${_file}" "${outpath_inc}"
    done
    
    _path="pack_info_os_${os_type}_src_symbol_path"
    _list="pack_info_os_${os_type}_src_symbol_list[*]"
    for _file in ${!_list};do
        cp -R "${_conf_full_path}/${!_path}/${_file}" "${outpath_symbol}"
    done
    
    _path="pack_info_os_${os_type}_src_config_path"
    _list="pack_info_os_${os_type}_src_config_list[*]"
    for _file in ${!_list};do
        cp -R "${_conf_full_path}/${!_path}/${_file}" "${outpath_conf}"
    done
    
    _path="pack_info_os_${os_type}_src_doc_path"
    _list="pack_info_os_${os_type}_src_doc_list[*]"
    for _file in ${!_list};do
        cp -R "${_conf_full_path}/${!_path}/${_file}" "${outpath_doc}"
    done
}
function CompressFile() {
    if ! type zip >/dev/null 2>&1; then
        echo "[Error] zip uninstalled, not perform compression";
        exit 3
    fi
    _package_name="$1"
    zip -qr "${_package_name}.zip" "${_package_name}"
    return 0
}
function main() {
    ReadConfig
    ReadVersion
    
    version=$(GenerateFullVersionNum)
    package_name=$(GeneratePackageName "${version}")
    CreateOutDirStruct "${output_path}"/"${package_name}"
    CopyFiles

    CompressFile "${package_name}"
}

main
