#!/bin/bash
#
#  Copyright (c) 2020 General Electric Company. All rights reserved.
#
#  The copyright to the computer software herein is the property of
#  General Electric Company. The software may be used and/or copied only
#  with the written permission of General Electric Company or in accordance
#  with the terms and conditions stipulated in the agreement/contract
#  under which the software has been supplied.
#
#  author: RamaRao.Srikakulapu@ge.com
#

# find the routing based on $1
# $1: <app name>
function findCurrentRouting () {
    current_routes=$(cf app $1 | grep routes | awk -F':' '{print $2}' | xargs)
    
    if [[ ! -z "$current_routes" ]]; then
      printf "$current_routes"
    fi
}

# set the env var in the app $1 as the completion of step2
# $1: <app name>
function setStep2CompletedEnv () {
  result=$(cf set-env "$1" UPDATED $MISSION'-DONE')

  if [[ $result != *"FAILED"* ]]; then
    printf "0"
    return
  fi
  printf "1"
}