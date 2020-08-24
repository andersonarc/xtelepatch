#!/bin/sh
check() {
    if [ $? -ne 0 ]; then
        echo "<ERROR>"
        exit 1
    fi
}

echo
echo "[PACKAGE]"
echo "<START>"
mkdir -p pkg; 				  check
cp out/mod.apk pkg/mod.apk; 		  check
cp persistent/source.apk pkg/source.apk;  check
cp run/install-package.sh pkg/install.sh; check
cp docs/INSTALL.txt pkg/install.txt;      check
tar --gz -c pkg -f pkg.tar.gz; 		  check
rm -rf pkg;				  check
rm -rf work; 				  check
rm -rf out;  				  check
mkdir -p out; 				  check
mv pkg.tar.gz out/pkg.tar.gz;             check
echo "<DONE>"

