#!/bin/bash

set -e
ANDROID_JNI_LIB=vcx/wrappers/java/android/src/main/jniLibs

for arch in arm arm64 armv7 x86 x86_64
do
    arch_folder=${arch}
    if [ "${arch}" = "armv7" ]; then
        arch_folder="armeabi-v7a"
    fi
    mkdir -p ${ANDROID_JNI_LIB}/${arch_folder}
    cp -v runtime_android_build/libvcx_${arch}/libvcx.so ${ANDROID_JNI_LIB}/${arch_folder}/libvcx.so
    cp -v runtime_android_build/libvcx_${arch}/libz.so ${ANDROID_JNI_LIB}/${arch_folder}/libz.so
    cp -v runtime_android_build/libvcx_${arch}/liblog.so ${ANDROID_JNI_LIB}/${arch_folder}/liblog.so
    #cp -v runtime_android_build/libvcx_${arch}/libgnustl_shared.so ${ANDROID_JNI_LIB}/${arch_folder}/libgnustl_shared.so
done

pushd vcx/wrappers/java/android
    if [ -e local.properties ]; then
       rm local.properties
    fi
cat <<EOT >> local.properties
ndk.dir=/home/android/android-sdk-linux/ndk-bundle
sdk.dir=/home/android/android-sdk-linux
EOT
    pushd ../ci
        ./buildAar.sh
    popd
popd
