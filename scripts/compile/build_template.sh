#!/bin/bash/
set -e
SHELL_FOLDER=$(cd "$(dirname "$0")";pwd)
INSTALL_DIR=${1:-${SHELL_FOLDER}}
echo "INSTALL_DIR = ${INSTALL_DIR}"
SOURCE_CODE_DIR=${SHELL_FOLDER}/..
echo "SOURCE_CODE_DIR = ${SOURCE_CODE_DIR}"

if [ -d build ];then
    rm -rf build
fi

mkdir build && cd build

# load complie env 
source /opt/

# build
cmake ..

# compile
make && make install