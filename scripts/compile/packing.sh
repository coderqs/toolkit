#!/bin/bash

set -e
script_dir=$(dirname "$(readlink -f "$0")")
project_root="${script_dir}/../.."

os_type="${1:-"linux"}"
arch_type="${2:-"x64"}"
optim="${3:-"release"}"
program_version="${4:-""}"
program_config="${5:-"${project_root}/config/packing.cfg"}"

# 需要针对项目手动添加的部分
# 项目名称，输出的程序名、头文件目录都要和这个名字一致
project_name=""
program_name="${project_name}"
header_file_dir_name="${program_name}"
contains_attached_files_os=(\
)
attached_files=(\ # 除了默认会被打包以外的文件，需要写从 project_root 开始的相对路径
)
packing_is_exe=true
packing_is_shared_lib=true
packing_is_static_lib=true

use_std_dir_struct=true

# --------- 不是标准的目录结构需要手动指定下面的这些值 ------------
output_path="${project_root}/out"
version_file="${project_root}/VERSION"

program_path_bin=
program_path_lib=
program_path_inc=
program_path_symbol=
program_path_conf=
program_path_doc=

program_pr_lib=     # 库文件的前缀
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


