#! /usr/bin/bash 

## Alias: CompEng0001
## Created by: Richard Blair
## SID: 000947441
## Script created for the HPCC project

## This script takes in the number seconds and converts it into Y:M:W:D:H:M:S 

USAGE='echo -e Usage: $0 -m  --millseconds | -s --seconds | -M --Minute \n \t $1 value as numbers'


[ $# -eq 0 ] && { ${USAGE} ; exit 1; }

function displayTime {
 if [ $1 == '-m' ] ; then
  
      local T=$2 
      SECONDS=1000
      MINUTE=60000
      HOURS=3600000
      DAY=86400000
      WEEK=604800000
      MONTH=2628000000
      YEAR=31536000000

      local Y=$((${T}/${YEAR}))
      local YS=$((${Y}*${YEAR}))
      local YSLM=$((${T}-${YS}))

      #${T} - (${Y}*${YEAR}))/ ${MONTH}))
      local MM=$((${YSLM}/ ${MONTH}))
      local MMS=$((${MM}*${MONTH}))
      local MSLW=$((${YSLM}-${MMS}))

      local W=$((${MSLW}/${WEEK}))
      local WS=$((${W}*${WEEK}))
      local WSLD=$((${MSLW}-${WS}))

      local D=$((${WSLD}/${DAY}))
      local DS=$((${D}*${DAY}))
      local DSLH=$((${WSLD}-${DS}))

      local H=$((${DSLH}/${HOURS}))
      local HS=$((${H}*${HOURS}))
      local HSLM=$((${DSLH}-${HS}))

      local M=$((${HSLM}/${MINUTE}))
      local MS=$((${M}*${MINUTE}))
      local MSLS=$((${HSLM}-${MS}))

      local S=$((${MSLS}/${SECONDS}))
      local mmS=$((${S}*${SECONDS}))
      local mmSLmm=$((${MSLS}-${mmS}))

      local m=${mmSLmm}

      (( $Y > 0 )) && printf '%d Year(s) ' ${Y}
      (( $MM > 0 )) && printf '%d Month(s) ' ${MM}
      (( $W > 0 )) && printf '%d Week(s) ' ${W}
      (( $D > 0 )) && printf '%d Day(s) ' ${D}
      (( $H > 0 )) && printf '%d Hour(s) ' ${H}
      (( $M > 0 )) && printf '%d Minute(s) ' ${M}
      (( $S > 0 )) && printf '%d Second(s) ' ${S}
      (( $m > 0)) && printf '%d Millisecond(s)' ${m}
      (( ${Y} > 0 || ${MM} > 0 || ${W} > 0 || ${D} > 0 || ${H} > 0 || ${M} > 0 || ${S} > 0  || ${m} > 0 )) && printf '\n'  

 elif [ $1 == '-s' ] ; then
  
      local T=$2  
      SECOND=1
      MINUTE=60
      HOURS=3600
      DAY=86400
      WEEK=604800
      MONTH=2628000
      YEAR=31536000

      local Y=$((${T}/${YEAR}))
      local YS=$((${Y}*${YEAR}))
      local YSLM=$((${T}-${YS}))

      #${T} - (${Y}*${YEAR}))/ ${MONTH}))
      local MM=$((${YSLM}/ ${MONTH}))
      local MMS=$((${MM}*${MONTH}))
      local MSLW=$((${YSLM}-${MMS}))

      local W=$((${MSLW}/${WEEK}))
      local WS=$((${W}*${WEEK}))
      local WSLD=$((${MSLW}-${WS}))

      local D=$((${WSLD}/${DAY}))
      local DS=$((${D}*${DAY}))
      local DSLH=$((${WSLD}-${DS}))

      local H=$((${DSLH}/${HOURS}))
      local HS=$((${H}*${HOURS}))
      local HSLM=$((${DSLH}-${HS}))

      local M=$((${HSLM}/${MINUTE}))
      local MS=$((${M}*${MINUTE}))
      local MSLS=$((${HSLM}-${MS}))

      local S=${MSLS}

      (( $Y > 0 )) && printf '%d Year(s) ' ${Y}
      (( $MM > 0 )) && printf '%d Month(s) ' ${MM}
      (( $W > 0 )) && printf '%d Week(s) ' ${W}
      (( $D > 0 )) && printf '%d Day(s) ' ${D}
      (( $H > 0 )) && printf '%d Hour(s) ' ${H}
      (( $M > 0 )) && printf '%d Minute(s) ' ${M}
      (( $S > 0 )) && printf '%d Second(s) ' ${S}
      (( ${Y} > 0 || ${MM} > 0 || ${W} > 0 || ${D} > 0 || ${H} > 0 || ${M} > 0 || ${S} > 0 )) && printf '\n'  

 elif [ $1 == '-M' ]; then
      local T=$2 
      MINUTE=1
      HOURS=60
      DAY=1440
      WEEK=10080
      MONTH=43800
      YEAR=525600

      local Y=$((${T}/${YEAR}))
      local YS=$((${Y}*${YEAR}))
      local YSLM=$((${T}-${YS}))

      #${T} - (${Y}*${YEAR}))/ ${MONTH}))
      local MM=$((${YSLM}/ ${MONTH}))
      local MMS=$((${MM}*${MONTH}))
      local MSLW=$((${YSLM}-${MMS}))

      local W=$((${MSLW}/${WEEK}))
      local WS=$((${W}*${WEEK}))
      local WSLD=$((${MSLW}-${WS}))

      local D=$((${WSLD}/${DAY}))
      local DS=$((${D}*${DAY}))
      local DSLH=$((${WSLD}-${DS}))

      local H=$((${DSLH}/${HOURS}))
      local HS=$((${H}*${HOURS}))
      local HSLM=$((${DSLH}-${HS}))

      local M=$((${HSLM}/${MINUTE}))
      
      (( $Y > 0 )) && printf '%d Year(s) ' ${Y}
      (( $MM > 0 )) && printf '%d Month(s) ' ${MM}
      (( $W > 0 )) && printf '%d Week(s) ' ${W}
      (( $D > 0 )) && printf '%d Day(s) ' ${D}
      (( $H > 0 )) && printf '%d Hour(s) ' ${H}
      (( $M > 0 )) && printf '%d Minute(s) ' ${M}
      
      (( ${Y} > 0 || ${MM} > 0 || ${W} > 0 || ${D} > 0 || ${H} > 0 || ${M} > 0 )) && printf '\n'  
  
 else 
      ${USAGE}
 fi
}


displayTime $1 $2
