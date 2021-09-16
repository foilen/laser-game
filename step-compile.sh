#!/bin/bash

set -e

RUN_PATH="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd $RUN_PATH

./step-compile_multi.sh amd64

export CGO_ENABLED=1
export CC=arm-linux-gnueabi-gcc
export CGO_LDFLAGS="-g -O2 -L/usr/lib/arm-linux-gnueabihf/"
./step-compile_multi.sh arm
