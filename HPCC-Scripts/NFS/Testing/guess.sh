#! /usr/bin/bash

## Alias: CompEng0001
## Created by: Richard BLair
## SID: 000947441

PASSWORD="       £"
SSID="Guest"
PSK=$(wpa_passphrase ${SSID} "£      " )

echo -e ${PSK} 
 

