#!/bin/bash

set -e

RUN_PATH="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd $RUN_PATH

mkdir -p build/debian/

export ARCH=$1
export DEBARCH=$2

echo ----[ Create .deb for $ARCH ]----
DEB_FILE=$RUN_PATH/build/debian/laser-game_${VERSION}_$DEBARCH.deb
DEB_PATH=$RUN_PATH/build/$ARCH/debian_out/laser-game
rm -rf $DEB_PATH
mkdir -p $DEB_PATH $DEB_PATH/DEBIAN/ $DEB_PATH/usr/bin/

cat > $DEB_PATH/DEBIAN/control << _EOF
Package: laser-game
Version: $VERSION
Maintainer: Foilen
Architecture: $DEBARCH
Description: Create a laser labyrinth and use this application to monitor the end of the laser(s) on the wall
_EOF

cat > $DEB_PATH/DEBIAN/postinst << _EOF
#!/bin/bash

set -e
_EOF
chmod +x $DEB_PATH/DEBIAN/postinst

cp -rv build/$ARCH/bin/* $DEB_PATH/usr/bin/

cd $DEB_PATH/..
dpkg-deb --no-uniform-compression --build laser-game
mv laser-game.deb $DEB_FILE
