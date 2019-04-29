#!/bin/bash

cd /home/android/indy-sdk.evernym
#git checkout -- .
#git pull

./vcx/ci/scripts/androidBuild.sh arm stable 1.8.2 stable 1.8.2 libsovtoken_0.9.6-201811211720-4901e95_all.zip
./vcx/ci/scripts/androidBuild.sh arm64 stable 1.8.2 stable 1.8.2 libsovtoken_0.9.6-201811211720-4901e95_all.zip
./vcx/ci/scripts/androidBuild.sh armv7 stable 1.8.2 stable 1.8.2 libsovtoken_0.9.6-201811211720-4901e95_all.zip
./vcx/ci/scripts/androidBuild.sh x86 stable 1.8.2 stable 1.8.2 libsovtoken_0.9.6-201811211720-4901e95_all.zip
./vcx/ci/scripts/androidBuild.sh x86_64 stable 1.8.2 stable 1.8.2 libsovtoken_0.9.6-201811211720-4901e95_all.zip

# Copy the build artifacts to the correct location for android
# mkdir -p ./vcx/wrappers/java/android/src/main/jniLibs/arm
# mkdir -p ./vcx/wrappers/java/android/src/main/jniLibs/arm64
# mkdir -p ./vcx/wrappers/java/android/src/main/jniLibs/armeabi-v7
# mkdir -p ./vcx/wrappers/java/android/src/main/jniLibs/x86
# mkdir -p ./vcx/wrappers/java/android/src/main/jniLibs/x86_64
# cp -f ./vcx/libvcx/build_scripts/android/vcx/libvcx_arm/*.so ./vcx/wrappers/java/android/src/main/jniLibs/arm
# cp -f ./vcx/libvcx/build_scripts/android/vcx/libvcx_arm64/*.so ./vcx/wrappers/java/android/src/main/jniLibs/arm64
# cp -f ./vcx/libvcx/build_scripts/android/vcx/libvcx_armv7/*.so ./vcx/wrappers/java/android/src/main/jniLibs/armeabi-v7
# cp -f ./vcx/libvcx/build_scripts/android/vcx/libvcx_x86/*.so ./vcx/wrappers/java/android/src/main/jniLibs/x86
# cp -f ./vcx/libvcx/build_scripts/android/vcx/libvcx_x86_64/*.so ./vcx/wrappers/java/android/src/main/jniLibs/x86_64
# rm -rf ./runtime_android_build/libvcx_arm;cp -rf ./vcx/libvcx/build_scripts/android/vcx/libvcx_arm ./runtime_android_build
# rm -rf ./runtime_android_build/libvcx_arm64;cp -rf ./vcx/libvcx/build_scripts/android/vcx/libvcx_arm64 ./runtime_android_build
# rm -rf ./runtime_android_build/libvcx_armv7;cp -rf ./vcx/libvcx/build_scripts/android/vcx/libvcx_armv7 ./runtime_android_build
# rm -rf ./runtime_android_build/libvcx_x86;cp -rf ./vcx/libvcx/build_scripts/android/vcx/libvcx_x86 ./runtime_android_build
# rm -rf ./runtime_android_build/libvcx_x86_64;cp -rf ./vcx/libvcx/build_scripts/android/vcx/libvcx_x86_64 ./runtime_android_build

./vcx/ci/scripts/androidPackage.sh
# ANDROID_JNI_LIB=./vcx/wrappers/java/android/src/main/jniLibs

# for arch in arm arm64 armv7 x86 x86_64
# do
#     arch_folder=${arch}
#     if [ "${arch}" = "armv7" ]; then
#         arch_folder="armeabi-v7a"
#     fi
#     mkdir -p ${ANDROID_JNI_LIB}/${arch_folder}
#     cp -v runtime_android_build/libvcx_${arch}/libvcx.so ${ANDROID_JNI_LIB}/${arch_folder}/libvcx.so
#     cp -v runtime_android_build/libvcx_${arch}/libz.so ${ANDROID_JNI_LIB}/${arch_folder}/libz.so
#     cp -v runtime_android_build/libvcx_${arch}/liblog.so ${ANDROID_JNI_LIB}/${arch_folder}/liblog.so
#     #cp -v runtime_android_build/libvcx_${arch}/libgnustl_shared.so ${ANDROID_JNI_LIB}/${arch_folder}/libgnustl_shared.so
# done

# # Run the android tests
# cd ./vcx/wrappers/java
# rm ./android/build/outputs/apk/androidTest/debug/*.apk
# ./gradlew --no-daemon clean build --project-dir=android -x test
# adb logcat > logcat.tmp.out.ryMarsh44-merge_hyperledger.2.log
# ./gradlew --full-stacktrace --debug --no-daemon :connectedCheck --project-dir=android
