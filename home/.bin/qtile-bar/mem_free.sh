#!/bin/bash

FREE_MEM=$(free -mt | grep Mem: | awk '{ print $3 " MB" }')

#echo $FREE_MEM >> /opt/FREE_MEM.out
echo "  " $FREE_MEM
