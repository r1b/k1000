#!/bin/bash -e
#
# k1000.sh - Provisions an emulated mac99 machine with the ObjectMover software
#            and patches from the AX, GX, HX & SX expanders.
#
# Author: rob@computerlab.io

K1000_TMP_PATH=/tmp/k1000

function fetch_archives() {
    path=$1
    while read archive; do
        curl -o "$path/$(basename $archive)" $archive
    done < archives.txt
}

function copy_archives() {
    src=$1
    dst=$2
    mkdir -p "$dst/Desktop Folder/K1000/"
    cp "$src/*" "$dst/Desktop Folder/K1000/"
}

function cleanup_archives() {
    path=$1
    rm -rf $path
}

case $1 in
    install)
        ./mac99.sh install
        fetch_archives $K1000_TMP_PATH
        VOLUME=./mac99.sh mount
        copy_archives $K1000_TMP_PATH $VOLUME
        ./mac99.sh umount
        cleanup_archives $K1000_TMP_PATH
        ;;
    run)
        ./mac99.sh run
        ;;
    *)
        echo "usage"
        echo "  ./k1000.sh install"
        echo "  ./k1000.sh run"
        exit 1
        ;;
esac
