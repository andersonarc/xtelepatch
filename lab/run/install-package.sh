#!/bin/sh
check() {
    if [ $? -ne 0 ]; then
        echo "<ERROR>"
        exit 1
    fi
}

check_install() {
    if [ $? -ne 0 ]; then
        echo "<INSTALLING SOURCE.APK>"
        adb install source.apk
        check
        echo "<INSTALLED>"
        APK_PATH_SOURCE=$(adb shell pm path org.telegram.messenger)
    fi
}

echo
echo "[INSTALL]"
echo "<START>"
APK_PATH_SOURCE=$(adb shell pm path org.telegram.messenger)
check_install
APK_PATH=$(echo $APK_PATH_SOURCE | sed "s/package://")
STORAGE_PATH=/storage/emulated/0/.xtelepatch
adb shell mkdir -p $STORAGE_PATH
check
adb push mod.apk $STORAGE_PATH/base.apk
check
adb shell su -c cp $STORAGE_PATH/base.apk $APK_PATH
check
adb shell rm -rf $STORAGE_PATH 
check
echo "<DONE>"

