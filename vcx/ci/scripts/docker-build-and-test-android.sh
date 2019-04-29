#!/bin/bash

cd /home/vagrant/indy-sdk.evernym
#git checkout -- .
#git pull

# ./vcx/ci/scripts/androidBuild.sh arm stable 1.8.2 stable 1.8.2 libsovtoken_0.9.6-201811211720-4901e95_all.zip
# ./vcx/ci/scripts/androidBuild.sh arm64 stable 1.8.2 stable 1.8.2 libsovtoken_0.9.6-201811211720-4901e95_all.zip
# ./vcx/ci/scripts/androidBuild.sh armv7 stable 1.8.2 stable 1.8.2 libsovtoken_0.9.6-201811211720-4901e95_all.zip
./vcx/ci/scripts/androidBuild.sh x86 stable 1.8.2 stable 1.8.2 libsovtoken_0.9.6-201811211720-4901e95_all.zip
# ./vcx/ci/scripts/androidBuild.sh x86_64 stable 1.8.2 stable 1.8.2 libsovtoken_0.9.6-201811211720-4901e95_all.zip

# First time through run this script
#./vcx/ci/scripts/androidPackage.sh

# In subsequent runs you can use these faster steps to test
ANDROID_JNI_LIB=./vcx/wrappers/java/android/src/main/jniLibs

for arch in arm arm64 armv7 x86 x86_64
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
/tmp/android_build/platform-tools/adb logcat -b all -c
/tmp/android_build/platform-tools/adb logcat > logcat.tmp.1.out 2>&1 &
RUST_LOG=trace RUST_BACKTRACE=full ./gradlew --full-stacktrace --debug --no-daemon :connectedCheck --project-dir=android
