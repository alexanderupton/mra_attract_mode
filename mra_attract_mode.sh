#!/bin/bash
# mra_attract_mode : v0.01 : Alexander Upton : 02/01/2022

# Copyright (c) 2021 Alexander Upton <alex.upton@gmail.com>
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.

# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.

# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

# You can download the latest version of this script from:
# https://github.com/alexanderupton/MiSTer-Scripts

# v0.01 : Alexander Upton : 02/01/2021 : Initial Draft

# ========= IMMUTABLE ================

IFS=$'\n'
OIFS="$IFS"
OPTION=${1}
SWITCH=${2}

# ========= USAGE ====================

USAGE(){
 echo
 echo "mra_attract_mode.sh <option> <attribute>"
 echo "options:"
 echo "   -start : Launch a random Arcade game every X minutes."
 echo "   -stop : Stop cycling through random Arcade games. Current game remains active."
 echo 
 echo "attributes:"
 echo "     number : number in minutes before mra_attract_mode cycles to launch a random Arcade Game"
 echo
 echo "example:"
 echo "     ./mra_attract_mode.sh -start 5"
 echo
 exit 0
}

# ========= OPTIONS ==================

VER="0.01"
MRA_PATH="/media/fat/_Arcade"
SCRIPTS_DIR="/media/fat/Scripts"

# ========= CODE STARTS HERE =========

MRA_TIME_CHECK(){

 [[ -f ${SCRIPTS_DIR}/mra_attract_mode.ini ]] && source ${SCRIPTS_DIR}/mra_attract_mode.ini
 #[[ ! -n "${MRA_TIME}" ]] && export MRA_TIME="${2}"
 [[ -n "${SWITCH}" ]] && export MRA_TIME="${SWITCH}"

 # regular expression not working as expected. can not validate time value characters yet. 
 #MRA_NUMERICS='^[0-9]+$'
 #if ! [[ "$MRA_TIME" =~ $MRA_NUMERICS ]]; then
 # echo "mra_attract_mode: cycle time value ${MRA_TIME} is not a number. exiting."
 # exit 1
 #fi

 if [ ! -n "${MRA_TIME}" ]; then
  echo "mra_attract_mode: cycle time not defined. Defaulting to 5 minutes";echo
  export MRA_TIME="5"
 else
  echo "mra_attract_mode: cycle time set to ${MRA_TIME} minutes";echo
 fi

 # regular expression not working as expected. can not validate time value characters yet.
 MRA_NUMERICS='^[0-9]+$'
 if ! [[ "$MRA_TIME" =~ $MRA_NUMERICS ]]; then
  echo "mra_attract_mode: cycle time value ${MRA_TIME} is not a number. exiting."
  exit 1
 fi

}

MRA_RUN_CHECK(){

 if [ -f /dev/shm/mra_attract_mode.pid ]; then
  RUN_PID=$(cat /dev/shm/mra_attract_mode.pid)
  if [ -e /proc/${RUN_PID}/status ]; then
   echo;echo "mra_attract_mode: already active. exiting.";echo
   exit 1
  fi
 fi
 
 # PID management using files is ugly and shameful 
 echo "$BASHPID" > /dev/shm/mra_attract_mode.pid
 echo;echo "mra_attract_mode: starting"
 #MRA_ARCADE_EXEC

}

MRA_ARCADE_EXEC() {

 # PID management using files is ugly and shameful
 echo "$BASHPID" > /dev/shm/mra_attract_mode.pid

 for MRA in $(find ${MRA_PATH} -maxdepth 1 -type f -name "*.mra"); do
   MRA_LIST="${MRA_LIST}${MRA}\n"
 done 

 MRA_RANDOM=$(echo -e ${MRA_LIST} | shuf -n 1)
 
 # echo "load_core: ${MRA_RANDOM}"
 echo "load_core ${MRA_RANDOM}" > /dev/MiSTer_cmd

 unset MRA_LIST MRA_RANDOM
 # echo "Launching next game in ${MRA_TIME} minutes"
 sleep "${MRA_TIME}m"
 
 MRA_ARCADE_EXEC
}

MRA_STOP(){
 INT_PID="$$"
 RUN_PID=$(ps aux | awk '/mra_attract_mode.sh/ {print $1}' | head -n 1)
 
 if [ "${INT_PID}" == "${RUN_PID}" ]; then
  echo;echo "mra_attract_mode: not active. exiting.";echo
  exit 0
 fi

 if [ -n "${RUN_PID}" ]; then
  echo;echo "mra_attract_mode: exiting.";echo
  kill -9 ${RUN_PID}
 else
  echo;echo "mra_attract_mode.sh is not active...";echo
 fi
 exit 0

}

case ${OPTION} in
 -start)
  MRA_RUN_CHECK
  MRA_TIME_CHECK
  MRA_ARCADE_EXEC & ;;
 -stop) MRA_STOP ;;
 *) USAGE ;;
esac
