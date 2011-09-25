#!/bin/bash

KERNELGCCVERSION=$(cat /proc/version | awk '{print $9}' | awk 'BEGIN {FS="."} {print $1"."$2}')
NVIDIAINSTALLER='./'$(ls -t | grep NVIDIA | head -1)

# Options
NVBLOGOUT=
NVBUNINSTALL=
NVBSILENT=

while getopts lus o
do
    case "$o" in
        l)
            NVBLOGOUT='y'
            ;;
        u)
            NVBUNINSTALL='--uninstall'
            ;;
        s)
            NVBSILENT='--silent --opengl-headers --run-nvidia-xconfig'
            ;;
    esac
done

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

sudo /etc/init.d/gdm stop
echo 'Installing '$NVIDIAINSTALLER
sudo env CC=/usr/bin/gcc-$KERNELGCCVERSION $NVIDIAINSTALLER "$NVBUNINSTALL $NVBSILENT"
sudo /etc/init.d/gdm start

if [ -n "$NVBLOGOUT" ]
then
    kill -HUP $PPID
fi
