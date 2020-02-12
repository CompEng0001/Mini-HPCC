#! /usr/bin/expect -f

## Alias: CompEng0001
## Created by: Richard Blair
## SID: 000947441
read -p 'Are you sure you want to shutdown the cluster (y/n): ' INPUT

if [[ ${INPUT} == 'y' ]]; then
	#shutdown all
	$(ssh -t -q Node02 "sudo shutdown -h now")
	$(ssh -t -q Node03 "sudo shutdown -h now")
	sleep 8

	$(sudo shutdown -h now)
else 
	exit 0
fi



