#!/bin/bash
set -e
OUTPUTDIR=output
CURDIR=$(pwd)
export PATH=${PATH}:$(pwd)/vcx/ci/scripts
cd vcx/libvcx/
export RUST_FLAG=$1
export VERSION=$2
export REVISION=$3
echo "Updating Version in Cargo.toml file"
cargo update-version ${VERSION} ${REVISION}
echo "Updating Cargo"
if [ "${RUST_FLAG}" != "--no-test" ]; then
    echo "Testing libvcx.so"
    cargo test --no-default-features --features "ci" -- --test-threads=1
fi
echo "Building libvcx.so"
cargo build --no-default-features --features "ci"
echo "Updating libvcx.so File with Version"
cargo update-so
echo "Creating Libvcx Debian File"
cargo deb --no-build
echo "Moving Libvcx Debian File to Output Directory"
cp target/debian/*.deb $CURDIR/$OUTPUTDIR


