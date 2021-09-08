#!/bin/bash

set -e

RUN_PATH="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd $RUN_PATH

echo ----[ Create .deb ]----
DEB_FILE=laser-game_${VERSION}_amd64.deb
DEB_PATH=$RUN_PATH/build/debian_out/laser-game
rm -rf $DEB_PATH
mkdir -p $DEB_PATH $DEB_PATH/DEBIAN/ $DEB_PATH/usr/bin/

cat > $DEB_PATH/DEBIAN/control << _EOF
Package: laser-game
Version: $VERSION
Maintainer: Foilen
Architecture: amd64
Description: Create a laser labyrinth and use this application to monitor the end of the laser(s) on the wall
_EOF

cat > $DEB_PATH/DEBIAN/postinst << _EOF
#!/bin/bash

set -e
_EOF
chmod +x $DEB_PATH/DEBIAN/postinst

cp -rv build/bin/* $DEB_PATH/usr/bin/

cd $DEB_PATH/..
dpkg-deb --no-uniform-compression --build laser-game
mv laser-game.deb $DEB_FILE
