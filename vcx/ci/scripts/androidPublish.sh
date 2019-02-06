#!/usr/bin/env bash

set -e
vcx_version() {
    export PATH=${PATH}:$(pwd)/vcx/ci/scripts
    VCX_VERSION=$(toml_utils.py vcx/libvcx/Cargo.toml)
    echo "VCX_VERSION: ${VCX_VERSION}"
    eval "$1='${VCX_VERSION}'"
}

publish() {
    VCX_VERSION=''
    vcx_version VCX_VERSION
    AAR_FOLDER=vcx/wrappers/java/artifacts/aar
#    AAR_VERSION=$(find ${AAR_FOLDER} -type f -name 'com.evernym-vcx_*-release.aar'| perl -nle 'print $& if m{(?<=vcx_)(.*)(?=_x86)}' | head -1 | awk '{print $1}')
    echo "Uploading .aar with version number ==> ${VCX_VERSION}"
    cp -v settings.xml ${AAR_FOLDER}
    pushd ${AAR_FOLDER}

        mv com.evernym-vcx_*-release.aar com.evernym-vcx_${VCX_VERSION}_x86-armv7-release.aar

        mvn -e deploy:deploy-file \
            -Durl="https://evernym.mycloudrepo.io/repositories/libvcx-android" \
            -DrepositoryId="io.cloudrepo" \
            -Dversion=${VCX_VERSION} \
            -Dfile="com.evernym-vcx_${VCX_VERSION}_x86-armv7-release.aar" \
            -DartifactId="vcx" \
            -Dpackaging="aar" \
            -DgroupId="com.evernym" \
            --settings settings.xml
    popd
}
