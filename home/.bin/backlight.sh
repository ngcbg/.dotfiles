#!/usr/bin/env bash

#shopt -s nullglob
#set -a array /home/ngc/.bin/disptemp/*
#array=(/home/ngc/.bin/disptemp/*)
#echo ${#array[@]}


declare -a array

array=(mercury venus earth mars jupiter saturn uran)
echo ${array[1]}

