#! /usr/bin/bash

## Alias: CompEng0001
## Created by: Richard Blair
## SID: 000947441

while [ 1 ]
    do
		#Variable names for file paths
		JOBFILE="/mnt/nfs/Node03/Assignment/JobNode03.txt"
		JOBRESULTS="/mnt/nfs/Node03/Reporting/Node03Completed.txt"
		NODESTATUS="/mnt/nfs/Node03/Reporting/Node03Status.txt"

                #Initial md5sum from file path
                SUMOJOBFILE=$(md5sum ${JOBFILE})
                SUMNJOBFILE=$(md5sum ${JOBFILE})

		SUMORESULTSFILE=$(md5sum ${JOBRESULTS})
		SUMNRESULTSFILE=$(md5sum ${JOBRESULTS})
		echo -e "waiting for job..."
		#Continually check path for change, every # seconds 
		until [[ "${SUMOJOBFILE}" != "${SUMNJOBFILE}" ]]
				do
						SUMNJOBFILE=$(md5sum ${JOBFILE})
						sleep 5
				done

		CONFIG="/mnt/nfs/Release/Cracker.config"
		NoC=$(awk 'NR==4' ${CONFIG})

		if [[ ${NoC} == 5 ]]; then							# N C S
			taskset -c 0 bash /mnt/nfs/Release/CoreCracker.sh 3 5 5 &

		elif [[ ${NoC} == 6 ]]; then
			taskset -c 0 bash /mnt/nfs/Release/CoreCracker.sh 3 5 6 &
			taskset -c 1 bash /mnt/nfs/Release/CoreCracker.sh 3 6 6 &

		elif [[ ${NoC} == 7 ]]; then
			taskset -c 0 bash /mnt/nfs/Release/CoreCracker.sh 3 5 7 &
			taskset -c 1 bash /mnt/nfs/Release/CoreCracker.sh 3 6 7 &
			taskset -c 2 bash /mnt/nfs/Release/CoreCracker.sh 3 7 7 &

		else
			taskset -c 0 bash /mnt/nfs/Release/CoreCracker.sh 3 5 8 &
			taskset -c 1 bash /mnt/nfs/Release/CoreCracker.sh 3 6 8 &
			taskset -c 2 bash /mnt/nfs/Release/CoreCracker.sh 3 7 8 &
			taskset -c 3 bash /mnt/nfs/Release/CoreCracker.sh 3 8 8 &
		fi

		COREPIDS=$(pgrep -f "bash /mnt/nfs/Release/CoreCracker.sh")

		echo -e ${COREPIDS} >> /mnt/nfs/Node03/Reporting/CorePID.txt
		echo -e "Jobs assigned..."

		echo -e ""

		until [[ "${SUMORESULTSFILE}" != "${SUMNRESULTSFILE}" ]]
				do
								SUMNRESULTSFILE=$(md5sum ${JOBRESULTS})
								sleep 2
				done

		echo -e "jobs finished"
		tail -n +2  ${NODESTATUS} > ${NODESTATUS}
		echo -e "Inactive" >> ${NODESTATUS}
		tail -n +2 "${JOBFILE}" > "${JOBFILE}"
		kill -9 ${COREPIDS}
		sleep 10
	done

