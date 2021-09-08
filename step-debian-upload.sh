#!/bin/bash

set -e

RUN_PATH="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd $RUN_PATH

DOMAIN_NAME=deploy.foilen.com
IPFS_ROOT=/com.foilen.deploy

echo ----[ Fetch IPFS root if missing ]----
IPFS_CURRENT_PATH=$(ipfs resolve /ipns/$DOMAIN_NAME)
IPFS_ROOT_DIR_PATH=/ipfs/$(ipfs files stat $IPFS_ROOT 2> /dev/null | head -n 1)
if [ "$IPFS_ROOT_DIR_PATH" == "/ipfs/" ]; then
    echo ----[ IPFS root $IPFS_ROOT is missing. Getting it ]----
    ipfs files cp $IPFS_CURRENT_PATH $IPFS_ROOT
else
    echo ----[ IPFS root $IPFS_ROOT is present ]----
    echo Current $DOMAIN_NAME resolves to
    echo $IPFS_CURRENT_PATH
    echo Current root $IPFS_ROOT resolves to $IPFS_ROOT_DIR_PATH
    echo $IPFS_ROOT_DIR_PATH
fi

for DEB_FILE in $(ls build/debian/); do
    echo ----[ Add to IPFS $DEB_FILE ]----
    IPFS_FILE_ID=$(ipfs add -q $RUN_PATH/build/debian/$DEB_FILE | tail -n1)
    echo IPFS_FILE_ID: $IPFS_FILE_ID

    echo ----[ Put to IPFS under $IPFS_ROOT/laser-game/$DEB_FILE ]----
    ipfs files cp /ipfs/$IPFS_FILE_ID $IPFS_ROOT/laser-game/$DEB_FILE
done

echo; echo
echo ----[ New dnslink ]----
IPFS_ROOT_DIR_ID=$(ipfs files stat $IPFS_ROOT | head -n 1)
echo You can update your DNS Link for $DOMAIN_NAME to 
echo dnslink=/ipfs/$IPFS_ROOT_DIR_ID
echo
