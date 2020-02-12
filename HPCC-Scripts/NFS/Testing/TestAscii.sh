#! /usr/bin/bash

## Alias: CompEng0001
## Created by: Richard BLair
## SID: 000947441

I=32

while [ ${I} -le 127 ]
do


	CASCII=$(echo "${I}" | awk '{ printf("%c",$0); }')
	AASCII=${AASCII}${CASCII}
	
	I=$(( ${I} + 1 ))
done
echo ${AASCII}
#echo ${AASCII}
#WPAOUTPUT=$(wpa_passphrase "Guest" "      3!" )
#echo ${WPAOUTPUT}


#PSK=$(echo -e ${WPAOUTPUT} | awk '{print substr($5, 5)}')
#echo ${PSK}
