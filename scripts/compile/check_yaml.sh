#!/usr/bash

source ../../3rdparty/bash-yaml/script/yaml.sh

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

os_type=windows

echo "project_name = ${project_name}"
echo "version_file = ${version_file}"
echo "output_path = ${output_path}"
echo "program_name = ${program_name}"
echo "program_type = ${program_type}"
echo "pack_info_os_windows_src_binrary_path = ${pack_info_os_windows_src_binrary_path}"
echo "pack_info_os_windows_src_library_path = ${pack_info_os_windows_src_library_path}"
echo "pack_info_os_windows_src_include_path = ${pack_info_os_windows_src_include_path}"
echo "pack_info_os_windows_src_symbol_path = ${pack_info_os_windows_src_symbol_path}"
echo "pack_info_os_windows_src_config_path = ${pack_info_os_windows_src_config_path}"
echo "pack_info_os_windows_src_doc_path = ${pack_info_os_windows_src_doc_path}"
show_list "${pack_info_os_windows_src_binrary_list[*]}"
show_list "${pack_info_os_windows_src_library_list[*]}"
show_list "${pack_info_os_windows_src_include_list[*]}"
show_list "${pack_info_os_windows_src_symbol_list[*]}"
show_list "${pack_info_os_windows_src_config_list[*]}"
show_list "${pack_info_os_windows_src_doc_list[*]}"
echo "pack_info_os_centos_src_binrary_path = ${pack_info_os_centos_src_binrary_path}"
echo "pack_info_os_centos_src_library_path = ${pack_info_os_centos_src_library_path}"
echo "pack_info_os_centos_src_include_path = ${pack_info_os_centos_src_include_path}"
echo "pack_info_os_centos_src_symbol_path = ${pack_info_os_centos_src_symbol_path}"
echo "pack_info_os_centos_src_config_path = ${pack_info_os_centos_src_config_path}"
echo "pack_info_os_centos_src_doc_path = ${pack_info_os_centos_src_doc_path}"
show_list "${pack_info_os_windows_src_binrary_list[*]}"
show_list "${pack_info_os_windows_src_library_list[*]}"
show_list "${pack_info_os_windows_src_include_list[*]}"
show_list "${pack_info_os_windows_src_symbol_list[*]}"
show_list "${pack_info_os_windows_src_config_list[*]}"
show_list "${pack_info_os_windows_src_doc_list[*]}"
_path="pack_info_os_${os_type}_src_binrary_path"
echo "pack_info_os_${os_type}_src_binrary_path = ${!_path}"
