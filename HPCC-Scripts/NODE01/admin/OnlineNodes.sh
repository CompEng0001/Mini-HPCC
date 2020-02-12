#! /usr/bin/bash
## Alias: CompEng0001
## Created by: Richard Blair
## SID: 000947441


# -n turns of reverse name resolution since we only need the IP
# -sn Don't port scan 
# -oG - send "grepable" output 
# /Up$/ select only lines that end with Up ie the hosts that are online
# {print$2} prints the second whitespace-seperated field... i.e IP Address

echo  "Running nmap to determine which nodes are online, there must be 3"

NMAPRESULTS=$(nmap -n -sn 192.168.1.0/24 -oG -| awk '/Up$/{print$2}')

if [[ $(echo -e ${NMAPRESULTS} | awk '{print$1}') == "192.168.1.1" ]]; then
	NODE01=$(echo ${NMAPRESULTS} | awk '{print$1}')
else
	NODE01="NODE01 OFF"
fi

if [[ $(echo -e ${NMAPRESULTS} | awk '{print$2}') == "192.168.1.2" ]]; then
	NODE02=$(echo ${NMAPRESULTS} | awk '{print$2}')
elif [[ $(echo -e ${NMAPRESULTS} | awk '{print$3}') == "192.168.1.2" ]]; then
	NODE02=$(echo ${NMAPRESULTS} | awk '{print$3}')
else 
	NODE02="NODEO2 OFF "
fi


if [[ $(echo -e ${NMAPRESULTS} | awk '{print$2}') == "192.168.1.3" ]]; then
	NODE03=$(echo ${NMAPRESULTS} | awk '{print$2}')
elif [[ $(echo -e ${NMAPRESULTS} | awk '{print$3}') == "192.168.1.3" ]]; then
	NODE03=$(echo ${NMAPRESULTS} | awk '{print$3}')
else 
	NODE03="NODEO3 OFF "
fi


echo -e ""
echo -e "Nodes: "
echo -e "   Node01   |    Node02    |    Node03    |"
echo -e ${NODE01} "| " ${NODE02}   "|" ${NODE03} " |"
echo -e ""


