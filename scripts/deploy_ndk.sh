#! /bin/bash
ndk_version=$1
ndk_path=$2 # ndk 的根路径
deploy_path="${3:-"/opt/android-ndk"}"

"${ndk_path}"/ndk-build -v &> /dev/null
if [[ $? != 0 ]]; then
    echo "输入的第二个参数的路径下没有发现 ndk-build 等文件, 请确认后重新输入"
    return 1
fi

#arch_list=( "arm" "mips" "x86" "arm64" "mips64" "x86_64" )
#api_version_lsit=( 9 12 13 14 15 16 17 18 19 21 22 23 24 )
arch_list=( "arm" "arm64"  )
api_version_lsit=( 21 )

function CreateDeployDir(){
    mkdir -p "${deploy_path}"/android-ndk-"${ndk_version}"
    mkdir -p "${deploy_path}"/env
}

function GenerateEnvFileName(){
    arch=$1
    api_version=$2
    echo "ndk-${ndk_version}-${arch}-api${api_version}"
    return 0
}

function GenerateStartCmd(){
    return 0
}

function GetToolName(){
    arch=$1
    if [[ ${arch} = "arm" ]];then
        _NDK_TOOL="arm-linux-androideabi"
    elif [[ ${arch} = "arm64" ]];then
        _NDK_TOOL="aarch64-linux-android"
    elif [[ ${arch} = "mips" ]];then
        _NDK_TOOL="mipsel-linux-android"
    elif [[ ${arch} = "mips64" ]]; then
        _NDK_TOOL="mips64el-linux-android"
    elif [[ ${arch} = "x86" ]]; then
        _NDK_TOOL="x86"
    elif [[ ${arch} = "x86_64" ]]; then
        _NDK_TOOL="x86_64"
    fi
    echo "${_NDK_TOOL}"
    return 0
}

function GetArchFlags(){
    arch=$1
    if [[ ${arch} = "arm" ]];then
        _NDK_ARCH_FLAGS="-mthumb"
    elif [[ ${arch} = "arm64" ]];then
        _NDK_ARCH_FLAGS=
    elif [[ ${arch} = "mips" ]];then
        _NDK_ARCH_FLAGS=
    elif [[ ${arch} = "mips64" ]]; then
        _NDK_ARCH_FLAGS=
    elif [[ ${arch} = "x86" ]]; then
        _NDK_ARCH_FLAGS=
    elif [[ ${arch} = "x86_64" ]]; then
        _NDK_ARCH_FLAGS=
    fi
    echo "${_NDK_ARCH_FLAGS}"
    return 0
}

function GenerateEnvFile(){
    arch=$1
    api_version=$2
    toolchains_version=${3:-4.9}

    _NDK_TOOL=$(GetToolName "${arch}")
    _NDK_ARCH_FLAGS=$(GetArchFlags "${arch}")

    env_fn=$(GenerateEnvFileName "${arch}" "${api_version}")

    cut_date=$(date)
    cat >> "${deploy_path}"/env/"${env_fn}" <<EOF
--------------- ${cut_date} -----------------

export NDKROOT=${deploy_path}/android-ndk-${ndk_version}
export PATH=\$NDKROOT:\$PATH

INSTALLATION_PATH=~/output/ndk-${ndk_version}-${arch}
export prefix=\$INSTALLATION_PATH

export ANDROID_HOME=\$NDKROOT
export TOOLCHAIN=\$ANDROID_HOME/toolchains/${_NDK_TOOL}-${toolchains_version}/prebuilt/linux-x86_64
export CROSS_SYSROOT=\$NDKROOT/platforms/android-${api_version}/arch-${arch}/
export PATH=\$TOOLCHAIN/bin:\$PATH
export TOOL=${_NDK_TOOL}
export CC=\$TOOLCHAIN/bin/\${TOOL}-gcc
export CXX=\$TOOLCHAIN/bin/\${TOOL}-g++
export LINK=\${CXX}
export LD=\$TOOLCHAIN/bin/\${TOOL}-ld
export AR=\$TOOLCHAIN/bin/\${TOOL}-ar
export AS=\$TOOLCHAIN/bin/\${TOOL}-as
export RANLIB=\$TOOLCHAIN/bin/\${TOOL}-ranlib
export STRIP=\$TOOLCHAIN/bin/\${TOOL}-strip
export ARCH_FLAGS="${_NDK_ARCH_FLAGS} --sysroot=\${CROSS_SYSROOT}"
export ARCH_LINK=
export CFLAGS="\${ARCH_FLAGS} -fpic -ffunction-sections -funwind-tables -fstack-protector -fno-strict-aliasing -finline-limit=64"
export CXXFLAGS="\${CFLAGS} -frtti -fexceptions"
export LDFLAGS="\${ARCH_LINK}"

EOF

    GenerateStartCmd
}

function main(){
    CreateDeployDir
    cp -R "${deploy_path}"/* "${deploy_path}"/android-ndk-"${ndk_version}"/

    for _arch in "${arch_list[@]}"; do
        for _api in "${api_version_lsit[@]}"; do
            GenerateEnvFile "${_arch}" "${_api}"
        done
    done 

} 

main 