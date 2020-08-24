#!/bin/sh
check() {
    if [ $? -ne 0 ]; then
        echo "<ERROR>"
        exit 1
    fi
}

echo
echo "[SOURCE]"
echo "<START>"
APK_PATH_SOURCE=$(adb shell pm path org.telegram.messenger); check
APK_PATH=$(echo $APK_PATH_SOURCE | sed "s/package://");      check
STORAGE_PATH=/storage/emulated/0/.xtelepatch
adb shell mkdir $STORAGE_PATH;		       	             check
adb shell su -c cp $APK_PATH $STORAGE_PATH/base.apk;         check
mkdir -p work;   					     check
adb pull $STORAGE_PATH/base.apk persistent/source.apk;       check
adb shell rm -rf $STORAGE_PATH;          		     check
echo "<DONE>"
