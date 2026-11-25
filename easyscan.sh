#!/bin/bash

$args_num=$#
network=$1
port=$2

network_exp='^((25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){2}(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$'
port_exp='^(0|[1-9][0-9]{0,3}|[1-5][0-9]{4}|6[0-4][0-9]{3}|65[0-4][0-9]{2}|655[0-2][0-9]|6553[0-5])$'

if [[ $args_num != "2" || ! $network =~ $network_exp || ! $port =~ $port_exp ]]; then
	echo -e "\nEasyScan v1.0"
	echo "----------------------------------------------------"
	echo "How to use: ./easyscan.sh <IPv4 Network> <Port>"
	echo "Example: ./easyscan.sh 192.168.0 80"
	exit 1
fi

echo -e "\nEasyScan v1.0"
echo "----------------------------------------------------"
echo -e "Hosts that replied with SYN/ACK:\n"

for host in {1..254}; do
{
	ip="$network.$host"
	resp=$(hping3 -S -c 1 -p "$port" "$ip" 2>/dev/null | grep "flags=SA")
	
	if [[ $resp != "" ]]; then
		echo "Port $port is open on host $ip"
	fi 
} &
done

wait
