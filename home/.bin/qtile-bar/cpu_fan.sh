#!/bin/bash

#CPU_FAN=$(sensors | grep fan1 | awk '{ print $2" "$3}')
CPU_FAN=$(sensors | grep fan1 | awk '{ print $2" "}')

echo "$CPU_FAN"
