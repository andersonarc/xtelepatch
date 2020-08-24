#!/bin/sh
check() {
    if [ $? -ne 0 ]; then
        echo "<ERROR>"
        exit 1
    fi
}

echo
echo "[BUILD]"
echo "<START>"
mkdir -p work
cd ..
./gradlew assembleArm64_sdk23
check
cp TMessagesProj/build/outputs/apk/arm64_SDK23/release/app.apk lab/work/patch.apk
check
cd lab
echo "<DONE>"

