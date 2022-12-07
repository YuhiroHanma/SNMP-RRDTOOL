#!/bin/bash

ip=$1

echo "$ip"
in=$(date +%s)

#HOST-RESOURCES-MIB::hrProcessorLoad.6
in=$(date +%s)
data=$(snmpwalk -v2c -c private $ip HOST-RESOURCES-MIB::hrProcessorLoad.6)

IFS=" "
echo "$data"
read -ra demo <<< "$data"

out="${demo[3]}"
echo "$out"

echo "rrdtool update process_joaquin.rrd $in:$out"

rrdtool update process_joaquin.rrd $in:$out



#Generar la imagen:
#rrdtool graph joaquin.png  --start end-48h DEF:dsin=process_joaquin.rrd:data:MAX AREA:dsin#00FF00:"In traffic" LINE1:dsin#FF0000

#Crear BASE DATOS
#rrdtool create process_joaquin.rrd DS:data:GAUGE:300:0:10000 RRA:AVERAGE:0.5:1:600 RRA:MAX:0.5:1:600 RRA:MIN:0.5:1:600
