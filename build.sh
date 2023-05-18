#!/bin/bash
PREVIOUS_WORKING_DIRECTORY=$PWD
cd "$(dirname $0)"
tar -czvf ./archive.tar.gz ./archive/
cat ./minecraft-installer.sh >> ./minecraft-installer-build.sh
cat ./archive.tar.gz >> ./minecraft-installer-build.sh
chmod +x ./minecraft-installer-build.sh
cd $PREVIOUS_WORKING_DIRECTORY
exit 0