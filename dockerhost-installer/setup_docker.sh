#!/bin/bash

## Variables
curl=curl
instdir=/tmp/install
group=docker
user=pi
url_docker="https://get.docker.com/"

## Main
mkdir -p ${instdir}
cd ${instdir}

echo "* Download & Install Docker"
${curl} -sSL ${url_docker} | sh

echo "* Adding User ${user} to group ${group}"
usermod -aG ${group} ${user}

echo "* Start Docker"
systemctl start docker.service

echo "* Docker Version"
docker version

echo "* Starting a Linuxdockercontainer for 'Hello World!'"
docker run -ti resin/rpi-raspbian:jessie

##
exit 0