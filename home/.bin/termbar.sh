#!/bin/bash 

trap 'exec $0' HUP # Restart itself 
trap 'tput cnorm; exit 1' INT QUIT TERM 

_norm="\033[39m" 
_alrt="\033[31m" 
_warn="\033[33m" 
_rset="\033[0m" 
_hide="\033[2m" 

set -A _bat "${_norm}" "${_warn}" "${_alrt}" 
set -A _pwr "${_norm}" 
set -A _net "" "直" 
set -A _nic "enp8s0" 
set -A _vol "奄" "奔" "墳" 

function bat { 
  [[ $(apm -a) -eq 1 ]] \ 
    && echo -n "${_pwr[0]} " \ 
    || echo -n "${_bat[$(apm -b)]} " 
  echo -n "$(apm -l)%${_norm}" 
} 

function cal { 
  [[ $(date "+%H") -ge 6 && $(date "+%H") -le 22 ]] \ 
    && echo -n "${_norm}" \ 
    || echo -n "${_warn}" 
  echo -n $(date '+%a %d %b %H:%M')${_norm} 
} 

function cpu { 
  echo -n "龍$(sysctl -n hw.setperf)% " 
  echo -n " $(sysctl -n hw.sensors.cpu0.temp0 | cut -d '.' -f 1)°C" 
} 

function grp { 
  echo -n "${_hide}[ " 
  echo -n "$(xprop -root 32c '\t$0' _NET_CURRENT_DESKTOP | cut -f 2)" 
  echo -n " ]${_rset}" 
} 

function net { 
  [[ -z "$(ifconfig ${_nic[0]} | grep 'status: no carrier')" ]] \ 
    && (echo -n ${_net[0]} ; return) 
  echo -n $(ifconfig ${_nic[1]} | grep inet | awk '{ print "直" $2 " "}')
} 

function vol { 
  _v=$(sndioctl -n output.level | awk '{ print int($0*100) '}) 
  [[ $(sndioctl -n input.mute) -eq 1 ]] \ 
    && echo -n "${_norm}${_norm} " \ 
    || echo -n "${_warn}${_norm} " 
  [[ $(sndioctl -n output.mute) -eq 1 ]] \ 
    && echo -n "婢" \ 
    || echo -n "${_vol[$(($_v*3/101))]}" 
  echo -n "$_v%" 
} 

function win { 
  _wid=$(xprop -root 32x '\t$0' _NET_ACTIVE_WINDOW | cut -f 2) 
  _win=$(xprop -id $_wid '\t$0' _NET_WM_NAME | awk -F '"' '{ print $2 }') 
  echo -n " ${_win}" 
} 

tput civis # Hide cursor 

while true; do 
  _l="$(grp) $(win)" 
  _r="$(cpu) $(bat) $(net) $(vol) $(cal)" 

  #tput clear cup 1 0 
  tput cup 1 0 
  printf "%-120.120s\r" "$_l" 
  tput cup 1 120 
  printf "%110.110s" "$_r" 
  sleep 1 
done 

tput cnorm # Show cursor 

#EOF
