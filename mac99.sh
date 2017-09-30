#!/bin/bash

MAC99_ISO=macos-922-uni.iso
MAC99_IMG=MacOS9.2.img

cd "$(dirname "$0")"

case $1 in
    install)
        drives="-drive file=$MAC99_ISO,format=raw,media=cdrom -drive file=$MAC99_IMG,format=raw,media=disk"
        boot="-boot d"
        echo "Creating disk image"
        qemu-img create -f raw -o size=2G $MAC99_IMG
        echo "Booting mac99 from install disk"
        ;;
    run)
        drives="-drive file=$MAC99_IMG,format=raw,media=disk"
        boot="-boot c"
        echo "Booting mac99 from hard disk"
        ;;
    *)
        echo "usage: ./mac99.sh <install|run> [options]"
        exit 1
        ;;
esac

qemu-system-ppc -L pc-bios $boot -M mac99 -m 256 -prom-env 'auto-boot?=true' -prom-env 'boot-args=-v' -prom-env 'vga-ndrv?=true' $drives -device usb-mouse -device usb-kbd
