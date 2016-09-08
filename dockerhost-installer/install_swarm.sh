#!/bin/bash

ipadress="192.168.1.5"
ip_net="192.168.1"
ip_start=5
ip_end=16
port=2377
discoverfile="/etc/swarm/cluster_config"
tokenfile=/var/token.txt
if [ ! -d "/etc/swarm/" ]; then
	mkdir -p /etc/swarm
fi


if [ "$1" = "leader" ] || [ "$1" = "1" ]; then
	# SWARM Leader

	#echo "docker swarm init --listen-addr ${ipadress}"
	#docker swarm init --listen-addr ${ipadress}
	#echo "swarm manage ${ipadress:0:$ipl} -H=0.0.0.0:2375"
	#echo ${ipadress:0:$ipl}>$discoverfile

	while [ ${ip_end} -gt ${ip_start} ]; do
        ip="${ip_net}.${ip_start}"
        ip_start=$((ip_start+1))
        ipadress="${ipadress}${ip}:2375,"
	done
	ipl=${#ipadress}-1
	#docker swarm manage --discovery ${discoverfile} -H=0.0.0.0:2375

	docker run --rm swarm create
	token=$?
	docker run -d -p 2375:2375 --listen-addr ${ipadress:0:$ipl} swarm manage token://${token}
	echo $token >${tokenfile}
	echo "cat ${tokenfile}"
	cat ${tokenfile}
else
	# SWARM Member

	if [ -f ${tokenfile} ];then
		token=$(cat ${tokenfile})
	else
		echo "Enter token:"
		read token
	fi

	if [ "${token}" == "" ]; then
		echo "Token is empty!"
		exit 1;
	fi
	echo "docker run -d  swarm join --token ${token} ${ipadress}:${port}"
	docker run -d docker swarm join ${ipadress}:${port} token://${token}
fi
exit 0
