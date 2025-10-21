#!/usr/bin/env bash
# call from build/ ../scripts/cmake.sh

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
PICO_SDK_PATH=$(dirname $SCRIPT_DIR)"/3rd/pico-sdk/"

cmake -DCMAKE_BUILD_TYPE=Release -DPICO_SDK_PATH=${PICO_SDK_PATH} -DPICO_BOARD=pico2 ..
