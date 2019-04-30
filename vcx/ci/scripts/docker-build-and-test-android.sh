#!/bin/bash

cd /home/android/indy-sdk.evernym
#git checkout -- .
#git pull

# ./vcx/ci/scripts/androidBuild.sh arm stable 1.8.2 stable 1.8.2 libsovtoken_0.9.6-201811211720-4901e95_all.zip
# ./vcx/ci/scripts/androidBuild.sh arm64 stable 1.8.2 stable 1.8.2 libsovtoken_0.9.6-201811211720-4901e95_all.zip
# ./vcx/ci/scripts/androidBuild.sh armv7 stable 1.8.2 stable 1.8.2 libsovtoken_0.9.6-201811211720-4901e95_all.zip
./vcx/ci/scripts/androidBuild.sh x86 stable 1.8.2 stable 1.8.2 libsovtoken_0.9.6-201811211720-4901e95_all.zip
# ./vcx/ci/scripts/androidBuild.sh x86_64 stable 1.8.2 stable 1.8.2 libsovtoken_0.9.6-201811211720-4901e95_all.zip

###############################################################################################
# First time through run these steps
###############################################################################################
# These steps are only for vagrant
# wget -c http://download.virtualbox.org/virtualbox/6.0.6/VBoxGuestAdditions_6.0.6.iso -O /home/android/VBoxGuestAdditions_6.0.6.iso
# sudo -i
# mount /home/android/VBoxGuestAdditions_6.0.6.iso -o loop /mnt
# cd /mnt
# sh VBoxLinuxAdditions.run --nox11
# /etc/init.d/vboxadd setup
# chkconfig --add vboxadd
# chkconfig vboxadd on
# exit
# END vagrant steps
# if [ ! -d "/home/android/android-sdk-linux/android-ndk-r16b" ] ; then
#     echo "Downloading android-ndk-r16b-darwin-x86_64.zip"
#     cd /home/android/android-sdk-linux
#     wget -q https://dl.google.com/android/repository/android-ndk-r16b-darwin-x86_64.zip
#     unzip -qq android-ndk-r16b-darwin-x86_64.zip
#     ln -s android-ndk-r16b ndk-bundle
#     cd /home/android/indy-sdk.evernym
# else
#     echo "Skipping download android-ndk-r16b-linux-x86_64.zip"
# fi
# touch /home/android/.android/repositories.cfg
# yes | /home/android/android-sdk-linux/tools/bin/sdkmanager "build-tools;27.0.3"
# yes | /home/android/android-sdk-linux/tools/bin/sdkmanager "platforms;android-24"
# ./vcx/ci/scripts/androidPackage.sh
###############################################################################################


###############################################################################################
# In subsequent runs you can use these faster steps to test
###############################################################################################
# Use this command to start the emulator image
# ANDROID_SDK_ROOT=${ANDROID_SDK} ANDROID_HOME=${ANDROID_SDK} ${ANDROID_HOME}/tools/emulator -avd x86 -netdelay none -partition-size 4096 -netspeed full -no-audio -no-window -no-snapshot -no-accel &
ANDROID_JNI_LIB=./vcx/wrappers/java/android/src/main/jniLibs

cd /home/android/indy-sdk.evernym
#for arch in arm arm64 armv7 x86 x86_64
for arch in x86
do
    arch_folder=${arch}
    if [ "${arch}" = "armv7" ]; then
        arch_folder="armeabi-v7a"
    fi
    mkdir -p ${ANDROID_JNI_LIB}/${arch_folder}
    cp -v ./runtime_android_build/libvcx_${arch}/libvcx.so ${ANDROID_JNI_LIB}/${arch_folder}/libvcx.so
    cp -v ./runtime_android_build/libvcx_${arch}/libz.so ${ANDROID_JNI_LIB}/${arch_folder}/libz.so
    cp -v ./runtime_android_build/libvcx_${arch}/liblog.so ${ANDROID_JNI_LIB}/${arch_folder}/liblog.so
    #cp -v ./runtime_android_build/libvcx_${arch}/libgnustl_shared.so ${ANDROID_JNI_LIB}/${arch_folder}/libgnustl_shared.so
done

pushd ./vcx/wrappers/java/android
    if [ -e local.properties ]; then
       rm local.properties
    fi
cat <<EOT >> local.properties
ndk.dir=/home/android/android-sdk-linux/ndk-bundle
sdk.dir=/home/android/android-sdk-linux
EOT
popd
rm ./vcx/wrappers/java/android/build/outputs/apk/androidTest/debug/*.apk
cd ./vcx/wrappers/java
./gradlew --no-daemon clean build --project-dir=android -x test
/home/android/android-sdk-linux/platform-tools/adb logcat -b all -c
/home/android/android-sdk-linux/platform-tools/adb logcat > /home/android/indy-sdk.evernym/logcat.tmp.1.out 2>&1 &
LOGCAT_PID=$!
RUST_LOG=trace RUST_BACKTRACE=full ./gradlew --full-stacktrace --debug --no-daemon :connectedCheck --project-dir=android
kill -9 ${LOGCAT_PID}
echo "Output from the test is located at: /home/android/indy-sdk.evernym/logcat.tmp.1.out"
###############################################################################################
