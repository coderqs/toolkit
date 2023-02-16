#! /bin/bash
set -e

script_abs=$(readlink -f "$0")
script_dir=$(dirname $script_abs)
cd ${script_dir}

source ../general/clog_print.sh

optims="release"
has_addr_check=false
has_debug_info=false
# ����(������)

# ���
## asan
function HasAddrCheck() {
    file="$1"
    optim="${2:-"release"}"
    has_addr_check=false
    if [ ! $(ldd ${file} | grep asan) ];then
        has_addr_check=true
    fi

    if [ optim == "release" && has_addr_check == true ];then
        return 1;
    elif [ optim == "debug" && has_addr_check == false ]
        return 1;
    else
        return 0;
    fi
} 
## release �� debug �ֱ�
function IsDebugComplie() {
    file="$1"
    if [ $(readelf -S ${file} | grep .debug_) ]; then
        return 0
    else
        return 1
    fi
}

## Ŀ¼�ṹ���ļ������˶�

# ���

# ����(������)