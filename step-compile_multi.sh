#!/bin/bash

set -e

RUN_PATH="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd $RUN_PATH

export GOOS=linux
export GOARCH=$1

echo ----[ Compile $GOARCH ]----
go build -o build/$GOARCH/bin/laser-game ./main
