#!/bin/sh

check() {
    if [ $? -ne 0 ]; then
        echo "[FAILURE]"
        exit 1
    fi
}

echo "[XTELEPATCH]"
echo "<MAKE SURE YOU HAVE EXECUTED {./prepare.sh} BEFORE {./execute.sh}>"
. run/setup.sh;   check
./run/build.sh;   check
./run/patch.sh;   check
./run/package.sh; check
echo "[EXIT]"
