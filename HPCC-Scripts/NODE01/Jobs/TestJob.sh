#! /usr/bin/bash

## Alias: CompEng0001
## Created by: Richard Blair
## SID: 000947441

#USAGE(){ echo "Usage: $1 1 duplicate, 2 split, $2 loop size. IE: Run 1 256 or Run 2 313" exit 1 }

NODE02STATUSFILE="/mnt/nfs/Reporting/Node02Status.txt"
NODE03STATUSFILE="/mnt/nfs/Reporting/Node03Status.txt"

NODE02STATUS=$(<${NODE02STATUSFILE})
NODE03STATUS=$(<${NODE03STATUSFILE})

#echo -e ${NODE02STATUS}

if [ "{$NODE02STATUS}" != 'Active' ] && [ "${NODE03STATUS}" != 'Active' ];then

	tail -n +2 ${NODE02STATUSFILE} > ${NODE02STATUSFILE}
	tail -n +2 ${NODE03STATUSFILE} > ${NODE03STATUSFILE}
	echo -e "Active" >> ${NODE02STATUSFILE}
	echo -e "Active" >> ${NODE03STATUSFILE}


	if [ $1 == '1' ];then
		TASK1=$2
		NODE02TASK=${TASK1}
		NODE03TASK=${TASK1}
		echo -e ""
		echo -e "Job will be duplicated | Job Size is: "  ${TASK1} " | Job Node02: " ${NODE02TASK} " | Job Node03: " ${NODE03TASK}

		echo -e ${TASK1} " " ${NODE02TASK} > /mnt/nfs/Assignment/JobNode02.txt && echo -e ${TASK1} " " ${NODE03TASK} > /mnt/nfs/Assignment/JobNode03.txt

	elif [ $1 == "2" ]; then
		TASK2=$2

		NODE02TASK=$(( ( ${TASK2} - ( ${TASK2} / 2 )) ))
		NODE03TASK=$(( ( ${TASK2} - ${NODE02TASK} ) ))

		echo -e ""
		echo -e "Job has been split by 2 | Job Size is: "  ${TASK2} " | Job Node02: " ${NODE02TASK} " | Job Node03: " ${NODE03TASK}
		echo -e ${TASK2} " " ${NODE02TASK} > /mnt/nfs/Assignment/JobNode02.txt && echo -e ${TASK2} " "  ${NODE03TASK} > /mnt/nfs/Assignment/JobNode03.txt

	fi
	bash ClusterControls/TaskNotification.sh

else
	echo -e "Node02 and Node03 are currently performing a job"
fi

