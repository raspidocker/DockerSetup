#!/bin/bash
###
# DESC:
# Script for make a image width dd to sdcard. The Image comes from a HD.
###

diskutil list

imagename=$1;
if [ "$imagename" = "" ]; then
	echo "Usage: $0 <imagename>"
	exit 1;
fi

echo -e "Which Device [disk2]:"
device=/dev/disk2;
read disk
if [ "${disk}" != "" ]; then
	device=/dev/${disk}
fi

echo "imagename=$imagename";
echo "device=$device";
echo "[RETURN]";
read
clear

diskutil list
diskutil unmount ${device}s0
diskutil unmount ${device}s1
diskutil unmount ${device}s2
#diskutil unmount ${device}
echo "Start dd if=${imagename} of=${device} bs=1m? [RETURN]"
read
dd if=${imagename} of=${device} bs=1m
diskutil unmount ${device}
diskutil eject ${device}
echo "Finished - unmounted and ejected"


