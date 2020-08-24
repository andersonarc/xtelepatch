#!/bin/sh
check() {
    if [ $? -ne 0 ]; then
        echo "<ERROR>"
        exit 1
    fi
}

echo
echo "[PATCH]"
echo "<START>"
cp persistent/source.apk work/mod.apk; check
cd work;                     check
unzip patch.apk classes.dex; check
zip -d mod.apk classes.dex;  check
zip -r mod.apk classes.dex;  check
rm classes.dex;              check
cd ..;                       check
mkdir -p out;                check
mv work/mod.apk out/mod.apk; check
echo "<DONE>"

