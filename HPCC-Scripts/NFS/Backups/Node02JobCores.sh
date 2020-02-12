#! /usr/bin/bash

## Alias: CompEng0001
## Created by: Richard Blair
## SID: 000947441


while [ 1 ]
    do
		#Variable names for file paths
		JOBFILE="/mnt/nfs/Node02/Assignment/JobNode02.txt"
		JOBRESULTS="/mnt/nfs/Node02/Reporting/Node02Completed.txt"
		NODESTATUS="/mnt/nfs/Node02/Reporting/Node02Status.txt"

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

			if [[ ${NoC} == 1 ]]; then  					#  N C S
				taskset -c 0 bash /mnt/nfs/Release/CoreCracker.sh 2 1 1 &

			elif [[ ${NoC} == 2 ]]; then
				taskset -c 0 bash /mnt/nfs/Release/CoreCracker.sh 2 1 2 &
				taskset -c 1 bash /mnt/nfs/Release/CoreCracker.sh 2 2 2 &

			elif [[ ${NoC} == 3 ]]; then
				taskset -c 0 bash /mnt/nfs/Release/CoreCracker.sh 2 1 3 &
				taskset -c 1 bash /mnt/nfs/Release/CoreCracker.sh 2 2 3 &
				taskset -c 2 bash /mnt/nfs/Release/CoreCracker.sh 2 3 3 &

			elif [[ ${NoC} == 4 ]]; then
				taskset -c 0 bash /mnt/nfs/Release/CoreCracker.sh 2 1 4 &
				taskset -c 1 bash /mnt/nfs/Release/CoreCracker.sh 2 2 4 &
				taskset -c 2 bash /mnt/nfs/Release/CoreCracker.sh 2 3 4 &
				taskset -c 3 bash /mnt/nfs/Release/CoreCracker.sh 2 4 4 &

			elif [[ ${NoC} == 5 ]]; then
				taskset -c 0 bash /mnt/nfs/Release/CoreCracker.sh 2 1 5 &
				taskset -c 1 bash /mnt/nfs/Release/CoreCracker.sh 2 2 5 &
				taskset -c 2 bash /mnt/nfs/Release/CoreCracker.sh 2 3 5 &
				taskset -c 3 bash /mnt/nfs/Release/CoreCracker.sh 2 4 5 &

			elif [[ ${NoC} == 6 ]]; then
				taskset -c 0 bash /mnt/nfs/Release/CoreCracker.sh 2 1 6 &
				taskset -c 1 bash /mnt/nfs/Release/CoreCracker.sh 2 2 6 &
				taskset -c 2 bash /mnt/nfs/Release/CoreCracker.sh 2 3 6 &
				taskset -c 3 bash /mnt/nfs/Release/CoreCracker.sh 2 4 6 &

			elif [[ ${NoC} == 7 ]]; then
				taskset -c 0 bash /mnt/nfs/Release/CoreCracker.sh 2 1 7 &
				taskset -c 1 bash /mnt/nfs/Release/CoreCracker.sh 2 2 7 &
				taskset -c 2 bash /mnt/nfs/Release/CoreCracker.sh 2 3 7 &
				taskset -c 3 bash /mnt/nfs/Release/CoreCracker.sh 2 4 7 &

			elif [[ ${NoC} == 8 ]]; then
				taskset -c 0 bash /mnt/nfs/Release/CoreCracker.sh 2 1 8 &
				taskset -c 1 bash /mnt/nfs/Release/CoreCracker.sh 2 2 8 &
				taskset -c 2 bash /mnt/nfs/Release/CoreCracker.sh 2 3 8 &
				taskset -c 3 bash /mnt/nfs/Release/CoreCracker.sh 2 4 8 &

			else

			fi

				COREPIDS=$(pgrep -f "bash /mnt/nfs/Release/CoreCracker.sh")

				echo -e ${COREPIDS} >> /mnt/nfs/Node02/Reporting/CorePID.txt
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

