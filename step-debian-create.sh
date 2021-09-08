#!/bin/bash

set -e

RUN_PATH="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd $RUN_PATH

./step-debian-create_multi.sh amd64 amd64
./step-debian-create_multi.sh arm armhf
