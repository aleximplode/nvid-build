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

#ls -la /usr/bin/gcc
mv /usr/bin/gcc /tmp/$$.gcc
ln -s /usr/bin/gcc-$KERNELGCCVERSION /usr/bin/gcc
#ls -la /usr/bin/gcc
/etc/init.d/gdm stop
$NVIDIAINSTALLER
/etc/init.d/gdm start
#ls -la /usr/bin/gcc
mv /tmp/$$.gcc /usr/bin/gcc
