#!/bin/bash
PREVIOUS_WORKING_DIRECTORY=$PWD
BUILD_TARGET="minecraft-installer-build.sh"
cd "$(dirname $0)"
tar -czvf ./archive.tar.gz ./archive/
cat ./minecraft-installer.sh >> ./$BUILD_TARGET
base64 ./archive.tar.gz >> ./$BUILD_TARGET
rm ./archive.tar.gz
chmod +x ./$BUILD_TARGET
cd $PREVIOUS_WORKING_DIRECTORY
echo "Build complete! Saved to $BUILD_TARGET"
exit 0