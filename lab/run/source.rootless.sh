#!/bin/sh
check() {
    if [ $? -ne 0 ]; then
        echo "<ERROR>"
        exit 1
    fi
}

echo
echo "[SOURCE ROOTLESS]"
echo "<START>"
APK_PATH_SOURCE=$(adb shell pm path org.telegram.messenger)
check
APK_PATH=$(echo $APK_PATH_SOURCE | sed "s/package://")
check
adb pull $APK_PATH work/source.apk
check
echo "<DONE>"

