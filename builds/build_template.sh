#! /bin/bash
set -e
SHELL_FOLDER=$(cd "$(dirname "$0")";pwd)
INSTALL_DIR=${1:-${DROOT}}
TARGET_PLATFORM="linux"

PROJECT_ROOT=${SHELL_FOLDER}/../..

## ���ر��뻷��
#if [ not `aarch64-himix200-linux-gcc -v` ];then
#    echo "No HISI compiler detected. Try to load the HISI cross-compile environment ..."
#    source /opt/hisi-linux/env/hisi3531_arm64
#    if [ $? and `aarch64-himix200-linux-gcc -v` ]; then
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
export DROOT=${DROOT}/${TARGET_PLATFORM}

cmake ${PROJECT_ROOT} \
      -DTARGET_PLATFORM=${TARGET_PLATFORM}

make 

## ���
bash ${PROJECT_ROOT}/scripts/program_packing.sh ${TARGET_PLATFORM} x64 release 

#################################
## cmake hisi3531 ����
#cmake ${PROJECT_ROOT} \
#      -DCMAKE_C_COMPILER=aarch64-himix200-linux-gcc \
#      -DCMAKE_CXX_COMPILER=aarch64-himix200-linux-c++ \
#      -DCMAKE_CXX_FLAGS=-D__AARCH64__ \
#      -DTARGET_PLATFORM=${TARGET_PLATFORM}

#################################
## cmake ios ����
#cmake ${PROJECT_ROOT} \
#      -DCMAKE_TOOLCHAIN_FILE=${PROJECT_ROOT}/cmake/ios.toolchain.cmake \
#      -G "Xcode" \
#      -DPLATFORM=OS64 \
#      -DCMAKE_OSX_ARCHITECTURES=arm64 \ # ���� 32 λʱ�������Ϊ armv7
#      -DCMAKE_OSX_DEPLOYMENT_TARGET="10.2" \
#      -DCMAKE_XCODE_ATTRIBUTE_CODE_SIGNING_REQUIRED="NO" \
#      -DCMAKE_XCODE_ATTRIBUTE_CODE_SIGN_IDENTITY="iOS Developer" \
#      -DCMAKE_CXX_FLAGS=-D__IOS__ \
#      -DTARGET_PLATFORM=${TARGET_PLATFORM}
#
## ���� iphoneos Release �汾
# xcodebuild -project ${PROJECT_NAME}.xcodeproj -alltargets -sdk iphoneos -configuration Release
