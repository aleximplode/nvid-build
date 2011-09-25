#!/bin/bash

KERNELGCCVERSION=$(cat /proc/version | awk '{print $9}' | awk 'BEGIN {FS="."} {print $1"."$2}')
NVIDIAINSTALLER='./'$(ls -t | grep NVIDIA | head -1)

if [ ! -e $NVIDIAINSTALLER ]
then
    echo 'NVIDIA installer not found!'
    exit 1
fi

if [ ! -e /usr/bin/gcc-$KERNELGCCVERSION ]
then
    echo 'GCC version $KERNELGCCVERSION not found!'
    exit 1
fi

/etc/init.d/gdm stop
echo 'Installing '$NVIDIAINSTALLER
env CC=/usr/bin/gcc-$KERNELGCCVERSION $NVIDIAINSTALLER
/etc/init.d/gdm start
