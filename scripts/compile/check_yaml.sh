#!/usr/bash
SHELL_FOLDER=$(cd "$(dirname "$0")";pwd)
source ${SHELL_FOLDER}/../../3rdparty/bash-yaml/script/yaml.sh

filename=packing.yaml

parse_yaml ${filename} && echo
create_variables ${filename}

function show_list() {
    local list=$1

    x=0
    for i in ${list[*]}; do
        echo "Item: $i";

        [ "$i" = "$x" ] || return 1
        x="$((x+1))"
    done

}

os_type_list=("windows" "centos")

os_type=windows

echo "project_name = ${project_name}"
echo "version_file = ${version_file}"
echo "output_path = ${output_path}"
echo "program_name = ${program_name}"
echo "program_type = ${program_type}"

for os_type in ${os_type_list[*]};do
    _os_name="pack_info_system_${os_type}_name"
    if [ -z ${${!_os_name}+x} ];then
        echo "[Error] No ${os_type} corresponding configuration is available"
        continue
    fi
    echo "-------- ${os_type} --------"
    _path="pack_info_os_${os_type}_src_binrary_path"
    _list="pack_info_os_${os_type}_src_binrary_list[*]"
    echo "${_path} = ${!_path}"
    show_list "${!_list}"
    
    _path="pack_info_os_${os_type}_src_library_path"
    _list="pack_info_os_${os_type}_src_library_list[*]"
    echo "${_path} = ${!_path}"
    show_list "${!_list}"
    
    _path="pack_info_os_${os_type}_src_include_path"
    _list="pack_info_os_${os_type}_src_include_list[*]"
    echo "${_path} = ${!_path}"
    show_list "${!_list}"
    
    _path="pack_info_os_${os_type}_src_symbol_path"
    _list="pack_info_os_${os_type}_src_symbol_list[*]"
    echo "${_path} = ${!_path}"
    show_list "${!_list}"
    
    _path="pack_info_os_${os_type}_src_config_path"
    _list="pack_info_os_${os_type}_src_config_list[*]"
    echo "${_path} = ${!_path}"
    show_list "${!_list}"
    
    _path="pack_info_os_${os_type}_src_doc_path"
    _list="pack_info_os_${os_type}_src_doc_list[*]"
    echo "${_path} = ${!_path}"
    show_list "${!_list}"
done
