#!/bin/bash

script_abs=$(readlink -f "$0")
script_dir=$(dirname $script_abs)

source ${script_dir}/../../3rdparty/ColorEchoForShell/dist/ColorEcho.bash
if [ $? ];then
    wget https://raw.githubusercontent.com/PeterDaveHello/ColorEchoForShell/master/dist/ColorEcho.bash
    source ColorEcho.bash
    if [ $? ];then
            echo "[Error] load ColorEcho.bash failure!" && exit 1 
        fi
fi

function LOG_ERROR() {
    echo.BoldRed $*
}

function LOG_WARNING() {
    echo.LightYellow $*
}

function LOG_MESSAGE() {
    echo.Green $*
}

function LOG_DEBUG() {
    echo.BoldGreen $*
}
