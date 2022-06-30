#!/bin/bash

set -e
script_dir=$(dirname "$(readlink -f "$0")")
project_root="${script_dir}/../.."

os_type="${1:-"linux"}"
arch_type="${2:-"x64"}"
optim="${3:-"release"}"
program_version="${4:-""}"
program_config="${5:-"${project_root}/config/packing.cfg"}"

# ��Ҫ�����Ŀ�ֶ���ӵĲ���
# ��Ŀ���ƣ�����ĳ�������ͷ�ļ�Ŀ¼��Ҫ���������һ��
project_name=""
program_name="${project_name}"
header_file_dir_name="${program_name}"
contains_attached_files_os=(\
)
attached_files=(\ # ����Ĭ�ϻᱻ���������ļ�����Ҫд�� project_root ��ʼ�����·��
)
packing_is_exe=true
packing_is_shared_lib=true
packing_is_static_lib=true

use_std_dir_struct=true

# --------- ���Ǳ�׼��Ŀ¼�ṹ��Ҫ�ֶ�ָ���������Щֵ ------------
output_path="${project_root}/out"
version_file="${project_root}/VERSION"

program_path_bin=
program_path_lib=
program_path_inc=
program_path_symbol=
program_path_conf=
program_path_doc=

program_pr_lib=     # ���ļ���ǰ׺
program_ext_exe=
program_ext_static_lib=
program_ext_shared_lib=
program_ext_symbol=

# ----------------------------
outpath_bin=
outpath_lib=
outpath_inc=
outpath_symbol=
outpath_conf=
outpath_doc=

function ReadConfig() {}
function ReadVersion() {}
function GenerateFullVersionNum() {}
function GeneratePackageName() {}
function CreateOutDirStruct() {}
function SwitchOs() {}
function SetOsEnv() {}
function CopyFile() {}
function CompressFile() {}
function main() {}


