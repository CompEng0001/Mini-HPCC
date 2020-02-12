#! /usr/bin/bash
## Alias: CompEng0001
## Created by: Richard Blair
## SID : 000947441

USAGE(){ echo "Usage: $0 -1 = Node02, -2 = Node03, -3 = Node02 & 03, -4 = All Nodes" exit 1 }

[[ $# -ne 1 ]] && USAGE

if [ $1 == "-1" ]
then
        echo -e "Rebooting Node02"
        $(ssh -t Node02 sudo reboot)
        sleep 5
elif [ $1 == "-2" ] 
then
        echo -e "Rebooting Node03"
        $(ssh -t Node03 sudo reboot)
	sleep 5
elif [ $1 == "-3" ] 
then
        echo -e "Rebooting Node02 and Node03"
        $(ssh -t Node02 sudo reboot)
        $(ssh -t Node03 sudo reboot)
        sleep 5
elif [ $1 == "-4" ] 
then
        echo -e "rebooting Node02, Node03 & Node01"
        $(ssh -t Node02 sudo reboot)
        $(ssh -t Node03 sudo reboot)
        sleep 5
        $(sudo reboot)
else
	exit 0
fi
