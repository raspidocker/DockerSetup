#!/bin/bash
###
# DESC:
# Script for make a image width dd to sdcard. The Image comes from a URL and must be a ZIPfile.
###
imagename=$1;

### V: Hypriot
#version="hypriot-rpi-20160306-192317";
#zfile="${version}";
#URL="https://downloads.hypriot.com/${zfile}.img.zip"
###

### V: Official
version="2016-05-27";
zfile="${version}-raspbian-jessie";
#BUG in Versionnumbers
#URL="http://director.downloads.raspberrypi.org/raspbian/images/raspbian-${version}/${zfile}.zip";
URL="http://director.downloads.raspberrypi.org/raspbian/images/raspbian-2016-05-31/${zfile}.zip";
###

diskutil list
device=/dev/disk2;

echo -e "Which Device [disk2]:"
read disk
if [ "${disk}" != "" ]; then
	device=/dev/${disk}
fi

if [ "$imagename" = "" ]; then
	echo "Usage: $0 <imagename>"
	exit 1;
elif [ "$imagename" = "download" ]; then
	echo -e "Downloading ";
	curl ${URL} .
	unzip zfile.zip
	imagename=${version}.img
fi

echo "imagename=$imagename";
echo "device=$device";
echo "[ next ]";
read
clear
diskutil list
diskutil unmount ${device}s0
diskutil unmount ${device}s1
diskutil unmount ${device}s2
#diskutil unmount ${device}
echo " dd if=${imagename} of=${device} bs=1m?"
read
dd if=${imagename} of=${device} bs=1m
diskutil unmount ${device}
diskutil eject ${device}
echo "Finished - unmounted and ejected"


