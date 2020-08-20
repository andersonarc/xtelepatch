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
rm out/mod.apk
cd work
unzip patch.apk classes.dex
check
cp source.apk mod.apk
check
zip -d mod.apk classes.dex
check
zip -r mod.apk classes.dex
check
rm classes.dex
cd ..
mv work/mod.apk out/mod.apk
check
echo "<DONE>"

