#!/bin/sh
SETUP_PATH="run/setup.sh"
SOURCE_PATH="persistent/source.apk"

check() {
    if [ $? -ne 0 ]; then
       echo "[FAILURE]"
       exit 1
    fi
}

source_first() {
    echo "<FIRST METHOD SELECTED>"
    while true; do
        read -p "<IS YOUR PHONE ROOTED? Y/N>: " ROOTED
        case $ROOTED in
            Y ) RUN_PATH="run/source.sh"; break;;
            N ) RUN_PATH="run/source-rootless.sh"; break;;
            * ) echo "<INVALID METHOD>";;
        esac
    done
    echo "<INSTALL TELEGRAM ON YOUR PHONE>"
    echo "<CONNECT VIA ADB AND CLICK ENTER>"
    read
    echo "<RUNNING {$RUN_PATH}>"
    ./$RUN_PATH; check
}

source_second() {
    echo "<SECOND METHOD SELECTED>"
    echo "<YOU SHOULD DOWNLOAD TELEGRAM APK FROM INTERNET>"
    while true; do
        read -p "<ENTER DOWNLOADED APK PATH>: " APK_PATH
        echo "<$APK_PATH>"
        if [ -f $APK_PATH ]; then
            break
        fi
        echo "<INVALID PATH>"
    done
    mkdir -p persistent;       check
    mv $APK_PATH $SOURCE_PATH; check
}

check_setup() {
    echo "<CHECKING FOR {$SETUP_PATH}>"
    if [ ! -f $SETUP_PATH ]; then
        echo "<{$SETUP_PATH} NOT FOUND>"
        while true; do
            read -p "<ENTER FULL PATH TO ANDROID SDK>: " SDK_PATH
            echo "<$SDK_PATH>"
            if [ -d $SDK_PATH ]; then
                break
            fi
            echo "<INVALID PATH>"
        done
        SDK_PATH=$(echo $SDK_PATH | sed "s/\\//\\\\\\//g"); check
        cat "run/setup.source.sh" | sed "s/ANDROID_SDK_PATH/$SDK_PATH/" > $SETUP_PATH; check
    fi
}

check_source() {
    echo "<CHECKING FOR {$SOURCE_PATH}>"
    if [ ! -f $SOURCE_PATH ]; then
        echo "<{$SOURCE_PATH} NOT FOUND>"
        while true; do
            read -p "<ENTER PREFERRED METHOD 1/2>: " METHOD
            case $METHOD in
                1 ) source_first; break;;
                2 ) source_second; break;;
                * ) echo "<INVALID METHOD>";;
            esac
        done
    fi
}

check_root_adb() {
    echo "<CONNECT VIA ADB AND CLICK ENTER>"
    read
    echo "<CHECKING FOR ROOT>"
    adb shell su -c exit; check
}

check_lucky_patcher() {
    STATUS=0
    read -p "<DO YOU HAVE LUCKY PATCHER INSTALLED? Y/N>: " METHOD
    case $METHOD in
       Y ) ;;
       * ) STATUS=1;;
    esac
    if [ $STATUS -ne 0 ]; then
         echo "<INSTALL LUCKY PATCHER FROM luckypatchers.com>"
         echo "<ADDITIONAL INSTRUCTIONS IN {docs/PATCH.txt}>"
         echo "[FAILURE]"
         exit 1
    fi
    read -p "<HAVE YOU APPLIED SIGNATURE VERIFICATION PATCH? Y/N>: " METHOD
    case $METHOD in
       Y ) ;;
       * ) STATUS=1;;
    esac
    if [ $STATUS -ne 0 ]; then
         echo "<APPLY SIGNATURE VERIFICATION PATCH IN LUCKY PATCHER>"
         echo "<ADDITIONAL INSTRUCTIONS IN {docs/PATCH.txt}>"
         echo "[FAILURE]"
         exit 1
    fi
}

check_gradlew() {
    echo "<RUNNING {$SETUP_PATH}>"
    . $SETUP_PATH; check
    cd ..
    ./gradlew;     check
    cd lab
}

echo "[XTELEPATCH]"
echo "<PREPARE FOR BUILD>"
echo
echo "<CHECKING SETUP>"
check_setup
echo "<SETUP CORRECT>"
echo
echo "<CHECK SOURCE>"
check_source
echo "<SOURCE CORRECT>"
echo
echo "<CHECK ADB AND ROOT>"
check_root_adb
echo "<ADB AND ROOT CORRECT>"
echo
echo "<CHECK LUCKY PATCHER>"
check_lucky_patcher
echo "<LUCKY PATCHER CORRECT>"
echo
echo "<CHECKING GRADLEW>"
check_gradlew
echo "<GRADLEW CORRECT>"
echo
echo "<EVERYTHING CORRECT>"
echo "<RUN {./execute.sh} TO PACKAGE XTELEPATCH>"
echo "[EXIT]"
