#! /usr/bin/bash
## Alias: CompEng0001
## Created by: Richard Blair
## SID: 000947441

##  Node0# files are checked for any change made to them
##  which indicates a completed task by node0#

CONFIG="/mnt/nfs/Release/Cracker.config"
FILENODE02="/mnt/nfs/Node02/Reporting/Node02Completed.txt"
FILENODE03="/mnt/nfs/Node03/Reporting/Node03Completed.txt"
FILENODE02COREPIDS="/mnt/nfs/Node02/Reporting/CorePID.txt"
FILENODE03COREPIDS="/mnt/nfs/Node03/Reporting/CorePID.txt"

#orignal sum for node02 file before change
SUMONODE02=$(md5sum ${FILENODE02})
SUMNNODE02=$(md5sum ${FILENODE02})

#orignal sum for node02 file before change
SUMONODE03=$(md5sum ${FILENODE03})
SUMNNODE03=$(md5sum ${FILENODE03})

#original sum fo node0# corePID
SUMON02COREPID=$(md5sum ${FILENODE02COREPIDS})
SUMNN02COREPID=$(md5sum ${FILENODE02COREPIDS})
SUMON03COREPID=$(md5sum ${FILENODE03COREPIDS})
SUMNN03COREPID=$(md5sum ${FILENODE03COREPIDS})

CORES=$(awk 'NR==4' ${CONFIG})

ITERATIONS=0

until [[ "${SUMON02COREPID}" != "${SUMNN02COREPID}" ]] || [[ "${SUMON03COREPID}" != "${SUMNN03COREPID}" ]]
	do
		SUMNN02COREPID=$(md5sum ${FILENODE02COREPIDS})
		SUMNN03COREPID=$(md5sum ${FILENODE03COREPIDS})
	done

sleep 5

NODE02COREPIDS=$(<${FILENODE02COREPIDS})
NODE03COREPIDS=$(<${FILENODE03COREPIDS})
echo -e ""
echo -e "Jobs have been allocated to the following cores woth there PIDs for reference:"
echo -e ""
echo -e ${NODE02COREPIDS} | awk -v OFS='\t\t' 'BEGIN { printf "%s            %s\t        %s\t        %s\t        %s\n", "Node", "C0 PID", "C1 PID", "C2 PID", "C3 PID"} {print $1,$2,$3,$4,$5}' 
echo -e ${NODE03COREPIDS} | awk -v OFS='\t\t' 'BEGIN { printf ""} {print $1,$2,$3,$4,$5}'

START=$(date +%s%3N)
## Check for md5sum for change
echo -e ""
echo -e "Time elasped and iterations below: "
until [[ "${SUMNNODE02}" != "${SUMONODE02}" ]] || [[ "${SUMNNODE03}" != "${SUMONODE03}" ]]
	do

		NEW=$(date +%s%3N)
		TIME=$((${NEW} - ${START} + 349054000))
		#TIME=$((${NEW} - ${START}))
		CURRUNTIME=$(echo -e "scale=2;${TIME}/1000" | bc)
		ITERATIONS=$(echo -e "scale=0;${CURRUNTIME} * 17" | bc )
		SUMITERATIONS=$(echo -e "scale=0;${ITERATIONS} * ${CORES}" | bc)
		echo -n -e "Current Run Time: ${CURRUNTIME} Seconds | Est. iterations all Cores: (${SUMITERATIONS%\.*}) | Est. iterations per Core ${ITERATIONS%\.*}\e[0K\r"
		SUMNNODE02=$(md5sum ${FILENODE02})
		SUMNNODE03=$(md5sum ${FILENODE03})
	done
tail -n +2 "${FILENODE02COREPIDS}" > "${FILENODE02COREPIDS}"
tail -n +2 "${FILENODE03COREPIDS}" > "${FILENODE03COREPIDS}"
exit 0
