#! /usr/bin/bash
## Alias: CompEng0001
## Created by: Richard Blair
## SID: 000947441

## run the pre-defined scripts to crack at 4 char password at the extreme

COMPLETED="FALSE"

CONFIG="/mnt/nfs/Release/Cracker.config"
NoC=$(awk 'NR==4' ${CONFIG}) # Number of Cores

## Get files for reading process
NODE02COMPLETED="/mnt/nfs/Node02/Reporting/Node02Completed.txt"
NODE03COMPLETED="/mnt/nfs/Node03/Reporting/Node03Completed.txt"

bash ClusterControls/Jobs/PreCalculation.sh 

## get md5sum to compare for change
SUMONODE02=$(md5sum ${NODE02COMPLETED})
SUMNNODE02=$(md5sum ${NODE02COMPLETED})
SUMONODE03=$(md5sum ${NODE03COMPLETED})
SUMNNODE03=$(md5sum ${NODE03COMPLETED})



if [[ ${NoC} < 5 ]]; then

	## Send command to Node0# to start job
	echo -e "Start" > /mnt/nfs/Node02/Assignment/JobNode02.txt

	bash ClusterControls/Jobs/TaskNotification.sh &

	until [[ COMPLETED == "TRUE" ]];
		do
			if [[ ${SUMONODE02} != ${SUMNNODE02} ]]; then
				ANSWER=$(<${NODE02COMPLETED}) #${GUESS}  ${ITERATIONS} ${DURATION} "
				PASSWORD=$(echo -e ${ANSWER} | awk '{print$1}')
                                ITERATIONS=$(echo -e ${ANSWER} | awk '{print$2}')
                                TIME=$(echo -e ${ANSWER} | awk '{print$3}')
                                NODE=$(echo -e ${ANSWER} | awk '{print$4}')
                                CORE=$(echo -e ${ANSWER} | awk '{print$5}')
                                echo -e "\r\r\r"
                                echo -e "\r"
                                echo -n -e "Completed by Node: ${NODE} | Core: ${CORE} | Password is: ${PASSWORD} | Iterations: ${ITERATIONS} | Time(s): "
                                echo -e "scale=4;${TIME}/1000" | bc
                                echo -e "${NODE},${NoC},${CORE},${PASSWORD},${TIME},${ITERATIONS}" >> /mnt/nfs/Release/log.csv
				sleep 4
				tail -n +2 "${NODE02COMPLETED}" > "${NODE02COMPLETED}"
				COMPLETED="TRUE"
				exit 1
			else
				SUMNNODE02=$(md5sum ${NODE02COMPLETED} )
			fi
		done

elif [[ ${NoC} > 4 ]]; then
	## Send command to Node0# to start job
	echo -e "Start" > /mnt/nfs/Node02/Assignment/JobNode02.txt
	echo -e "Start" > /mnt/nfs/Node03/Assignment/JobNode03.txt

	bash ClusterControls/Jobs/TaskNotification.sh &

	until [[ COMPLETED == "TRUE" ]];
		do
			if [[ ${SUMONODE02} != ${SUMNNODE02} ]]; then
				ANSWER=$(<${NODE02COMPLETED}) #${GUESS}  ${ITERATIONS} ${DURATION} "
		               # echo ${ANSWER}
				PASSWORD=$(echo -e ${ANSWER} | awk '{print$1}')
		                ITERATIONS=$(echo -e ${ANSWER} | awk '{print$2}')
		                TIME=$(echo -e ${ANSWER} | awk '{print$3}')
				NODE=$(echo -e ${ANSWER} | awk '{print$4}')
				CORE=$(echo -e ${ANSWER} | awk '{print$5}')
		                echo -e "\r\r\r"
				echo -e "\r"
				echo -n -e "Completed by Node: ${NODE} | Core: ${CORE} | Password is: ${PASSWORD} | Iterations: ${ITERATIONS} | Time(s): "
		                echo -e "scale=4;${TIME}/1000" | bc
				echo -e "${NODE},${NoC},${CORE},${PASSWORD},${TIME},${ITERATIONS}" >> /mnt/nfs/Release/log.csv
				sleep 4
				tail -n +2 "${NODE02COMPLETED}" > "${NODE02COMPLETED}"
				COMPLETED="TRUE"
				exit 1
			else
				SUMNNODE02=$(md5sum ${NODE02COMPLETED} )
			fi

			if [[ ${SUMONODE03} != ${SUMNNODE03} ]]; then
		                ANSWER=$(<${NODE03COMPLETED}) #${GUESS}  ${ITERATIONS} ${DURATION} "
		                PASSWORD=$(echo -e ${ANSWER} | awk '{print$1}')
		                ITERATIONS=$(echo -e ${ANSWER} | awk '{print$2}')
		                TIME=$(echo -e ${ANSWER} | awk '{print$3}')
				NODE=$(echo -e ${ANSWER} | awk '{print$4}')
				CORE=$(echo -e ${ANSWER} | awk '{print$5}')
		                echo -e "\r\r\r"
				echo -e "\r"
				echo -n -e "Completed by Node: ${NODE} | Core: ${CORE} | Password is: ${PASSWORD} | Iterations: ${ITERATIONS} | Time(s): "
		                echo -e "scale=4;${TIME}/1000" | bc
				echo -e "${NODE},${NoC},${CORE},${PASSWORD},${TIME},${ITERATIONS}" >> /mnt/nfs/Release/log.csv
				sleep 4
				tail -n +2 "${NODE03COMPLETED}" > "${NODE03COMPLETED}"
		                COMPLETED="TRUE"
		                exit 1
		    else
		                SUMNNODE03=$(md5sum ${NODE03COMPLETED} )
		    fi
		done
else
	echo "Enter the number of cores you want for to use for the job into ${CONFIG}" 
	exit 0
fi


