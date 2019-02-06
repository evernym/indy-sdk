#!/bin/bash

vcx_version() {

    export PATH=${PATH}:$(pwd)/vcx/ci/scripts
    VCX_VERSION=$(toml_utils.py vcx/libvcx/Cargo.toml)
    echo "VCX_VERSION: ${VCX_VERSION}"
    eval "$1='${VCX_VERSION}'"
}

setup_env() {
    set -e
    export SCRIPTS_PATH="vcx/libvcx/build_scripts/ios/mac"
    export BASE_DIR="../../../../.."
    export WRAPPER_BASE="vcx/wrappers/ios/vcx"
    export WRAPPER_LIBS="vcx/wrappers/ios/vcx/lib"
    export INDY_BRANCH=$1
    export INDY_VERSION=$2
    export SOVTOKEN_ZIP=$3
    export RUST_VERSION=$4
    cd ${SCRIPTS_PATH}

    cp -rf ~/OpenSSL-for-iPhone ${BASE_DIR}/.macosbuild
    cp -rf ~/libzmq-ios ${BASE_DIR}/.macosbuild
    cp -rf ~/combine-libs ${BASE_DIR}/.macosbuild

    ./mac.01.libindy.setup.sh ${RUST_VERSION}
    ./mac.02.libindy.env.sh
    ./mac.03.libindy.build.sh
    #./mac.04.libvcx.setup.sh
    ./mac.05.libvcx.env.sh

}

set_ios_platforms() {
    export IOS_ARCHS=$1
    export IOS_TARGETS=$2
}

clear_previous_builds() {
    # clear previous builds from jenkins machine
    if [ ! -z "$(ls -A /Users/jenkins/IOSBuilds/libvcxpartial/)" ]; then
       echo "deleting old libvcxpartial builds"
       rm /Users/jenkins/IOSBuilds/libvcxpartial/*
    fi
    if [ ! -z "$(ls -A /Users/jenkins/IOSBuilds/libvcxall/)" ]; then
       echo "deleting old libvcxall builds"
       rm /Users/jenkins/IOSBuilds/libvcxall/*
    fi
}

build_vcx() {
    IOS_ARCHS=$1
    ./mac.06.libvcx.build.sh nodebug cleanbuild ${IOS_ARCHS}
}

build_cocoapod() {
    LIBVCX_ARCH=$1
    IOS_ARCHS=$2
    IOS_TARGETS=$3
    VCX_VERSION=$4

    ./mac.11.copy.static.libs.to.app.sh
    ./mac.12.combine.static.libs.sh ${LIBVCX_ARCH} delete nodebug ${IOS_ARCHS}
    ./mac.13.build.cocoapod.sh ${LIBVCX_ARCH} ${IOS_TARGETS} ${VCX_VERSION}
}
VCX_VERSION=''
vcx_version VCX_VERSION
clear_previous_builds
set_ios_platforms "arm64,armv7,i386,x86_64" "aarch64-apple-ios,armv7-apple-ios,i386-apple-ios,x86_64-apple-ios"
setup_env $1 $2 $3 $4
build_vcx ${IOS_ARCHS}
build_cocoapod libvcxall ${IOS_ARCHS} ${IOS_TARGETS} ${VCX_VERSION}

# package only arm64 and armv7
set_ios_platforms "arm64,armv7" "aarch64-apple-ios,armv7-apple-ios"
build_cocoapod libvcxpartial ${IOS_ARCHS} ${IOS_TARGETS} ${VCX_VERSION}

# Todo: Separate testing from mac.13