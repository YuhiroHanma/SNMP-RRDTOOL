#!/bin/bash

ip=$1

echo "$ip"
in=$(date +%s)
data=$(snmpwalk -v2c -c private $ip HOST-RESOURCES-MIB::hrSystemProcesses.0)
#data=$(snmpwalk -v2c -c public $ip HOST-RESOURCES-MIB::hrSystemProcesses.0)

IFS=" "
echo "$data"
read -ra demo <<< "$data"

out="${demo[3]}"
echo "$out"
echo "rrdtool update process_bryan.rrd $in:$out"

rrdtool update process_bryan.rrd $in:$out


#Type: Gauge32

