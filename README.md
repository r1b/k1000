# k1000

Scripts for setting up ObjectMover for the Kurzweil K1000 on an emulated Mac OS 9 machine.

## prerequisites

Currently the scripts only work on Mac OS X. You will need a Mac OS 9 install ISO
(easy to find). You will also need the following utilities:

* curl
* hdiutil

## usage

The location of the install ISO and disk image are configured in the environment
variables `MAC99_ISO` and `MAC99_IMG` respectively.

```bash
    export MAC99_ISO=macos-922-uni.iso
    export MAC99_IMG=MacOS9.2.img
    ./k1000.sh
```

## todo

* Connect USB midi device on boot
* OS 9 install instructions
* Objectmover installation script

## references

[1] [Qemu for OSX](http://www.emaculation.com/doku.php/ppc-osx-on-qemu-for-osx)  
[2] [QEMU/Images](https://en.wikibooks.org/wiki/QEMU/Images)
[3] [Kurzweil MacObjectMover and Expanders](http://kurzweil.com/content/migration/downloads/pub/Kurzweil/Pro_Products/Other_Pro_Products/1000-1200_Series/MacObjectMover/)
