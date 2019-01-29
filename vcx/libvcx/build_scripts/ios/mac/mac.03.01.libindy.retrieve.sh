#!/bin/sh

set -e
INDY_BRANCH=$1
INDY_VERSION=$2
SOVTOKEN_ZIP=$3
source ./shared.functions.sh ${INDY_BRANCH} ${INDY_VERSION} ${SOVTOKEN_ZIP}

START_DIR=$PWD
WORK_DIR=$START_DIR/../../../../../.macosbuild
mkdir -p $WORK_DIR
WORK_DIR=$(abspath "$WORK_DIR")
SHA_HASH_DIR=$START_DIR/../..
SHA_HASH_DIR=$(abspath "$SHA_HASH_DIR")


function retrieveLib() {
    library=$1
    version=$2
    file=$3
    url=$4
    extension=$5

    if [[ -e ${BUILD_CACHE}/${library}/${version}/${library}.a ]]; then
        echo "${library} build for ios already exist"
    else
        mkdir -p ${BUILD_CACHE}/${library}/${version}
        cd ${BUILD_CACHE}/${library}/${version}
        curl --insecure -o ${version}-${file} ${url}

        if [[ ${extension} == "zip" ]]; then
            unzip ${version}-${file}
        else
            tar -xvzf ${version}-${file}
        fi

        # Deletes extra folders that we don't need
        rm -rf __MACOSX
        rm ${version}-${file}
    fi
}
retrieveLib "libindy" ${LIBINDY_VERSION} ${LIBINDY_FILE} ${LIBINDY_IOS_BUILD_URL} "tgz"
retrieveLib "libsovtoken-ios" ${LIBSOVTOKEN_VERSION} ${LIBSOVTOKEN_FILE} ${LIBSOVTOKEN_IOS_BUILD_URL} "zip"
retrieveLib "libnullpay" ${LIBNULLPAY_VERSION} ${LIBNULLPAY_FILE} ${LIBNULLPAY_IOS_BUILD_URL} "tgz"

