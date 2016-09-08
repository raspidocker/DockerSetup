#!/bin/bash

ipadress="192.168.1.5"
port=2377
token="Copy Token from leaderoutput"

if [ "$1" = "leader" ] || [ "$1" = "1" ]; then
	# SWARM Leader
	echo "docker swarm init --listen-addr ${ipadress}"
	docker swarm init --listen-addr ${ipadress}
else
	# SWARM Member
	echo "docker swarm join --token ${token} ${ipadress}:${port}"
	docker swarm join --token ${token} ${ipadress}:${port}
fi
