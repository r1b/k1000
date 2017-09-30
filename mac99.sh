#!/bin/bash -e
#
# mac99.sh - Helpers for working with mac99 on QEMU
#
# Author: rob@computerlab.io

MAC99_ISO=macos-922-uni.iso
MAC99_IMG=MacOS9.2.img

VOLUME=

function create_img() {
    qemu-img create -f raw -o size=2G $MAC99_IMG
}

function boot_mac99() {
    drives=$1
    boot=$2
    qemu-system-ppc -L pc-bios $boot -M mac99 -m 256 -prom-env 'auto-boot?=true' -prom-env 'boot-args=-v' -prom-env 'vga-ndrv?=true' $drives -device usb-mouse -device usb-kbd
}

cd "$(dirname "$0")"

case $1 in
    install)
        drives="-drive file=$MAC99_ISO,format=raw,media=cdrom -drive file=$MAC99_IMG,format=raw,media=disk"
        boot="-boot d"
        echo "Creating disk image"
        create_img
        echo "Booting mac99 from install disk"
        boot_mac99 $drives $boot
        ;;
    mount)
        echo "Mounting mac99 hard disk"
        mv $MAC99_IMG $MAC99_IMG.dmg
        VOLUME=$(hdiutil attach $MAC99_IMG.dmg | grep -o "/Volumes/*")
        echo $VOLUME
        ;;
    umount)
        echo "Unmounting mac99 hard disk"
        hdiutil detach $VOLUME
        mv $MAC99_IMG.dmg $MAC99_IMG
        VOLUME=
        ;;
    run)
        drives="-drive file=$MAC99_IMG,format=raw,media=disk"
        boot="-boot c"
        echo "Booting mac99 from hard disk"
        boot_mac99 $drives $boot
        ;;
    *)
        echo "usage:"
        echo "  ./mac99.sh install"
        echo "  ./mac99.sh mount"
        echo "  ./mac99.sh umount"
        echo "  ./mac99.sh run"
        exit 1
        ;;
esac
