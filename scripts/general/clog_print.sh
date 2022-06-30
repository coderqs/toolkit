#!/bin/bash

script_abs=$(readlink -f "$0")
script_dir=$(dirname $script_abs)

#source ${script_dir}/../../3rdparty/ColorEchoForShell/dist/ColorEcho.sh
source ../../3rdparty/ColorEchoForShell/dist/ColorEcho.bash

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
