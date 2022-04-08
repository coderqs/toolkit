#! /bin/bash
set -e
SHELL_FOLDER=$(cd "$(dirname "$0")";pwd)
INSTALL_DIR=${1:-${DROOT}}

PROJECT_ROOT=${SHELL_FOLDER}/../..

## ���ر��뻷��
#if [ not `aarch64-himix200-linux-gcc -v` ];then
#    echo "No HISI compiler detected. Try to load the HISI cross-compile environment ..."
#    source /opt/hisi-linux/env/hisi3531_arm64
#    if [ $? ]; then
#        echo "loaded."
#    else
#        echo "Load failed!"
#        exit 1
#    fi
#fi

## ��������Ŀ¼
if [ -d build ];then
    rm -rf build
fi
mkdir build && cd build

## ����
export DROOT=${DROOT}

cmake ${PROJECT_ROOT} \
      #-DCMAKE_C_COMPILER=aarch64-himix200-linux-gcc \
      #-DCMAKE_CXX_COMPILER=aarch64-himix200-linux-c++ \
      #-DCMAKE_CXX_FLAGS=-D__AARCH64__ \
      -DTARGET_PLATFORM="linux" 

make 

## ���
bash ${PROJECT_ROOT}/scripts/program_packing.sh linux x64 release 