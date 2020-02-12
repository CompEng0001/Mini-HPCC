#! /usr/bin/bash 

## Alias: CompEng0001
## Created By: Richard Blair
## SID:  000947441

NODE02PIDS=$(</mnt/nfs/Node02/Reporting/CorePID.txt)
NODE03PIDS=$(</mnt/nfs/Node03/Reporting/CorePID.txt)
TASKNOTIFIER=$(pgrep -f "bash ClusterControls/Jobs/TaskNotification.sh")
MULTICORE=$(pgrep -f "bash ClusterControls/Jobs/MultiCore.sh")

kill ${TASKNOTIFIER} ${MULTICORE}

NODEKILLED2=$(ssh Node02 "kill ${NODE02PIDS}")
NODEKILLED3=$(ssh Node03 "kill ${NODE03PIDS}")

JOBFILE02="/mnt/nfs/Node02/Assignment/JobNode02.txt"
JOBFILE03="/mnt/nfs/Node03/Assignment/JobNode03.txt"

tail -n +2 "${JOBFILE02}" > "${JOBFILE02}"
tail -n +2 "${JOBFILE03}" > "${JOBFILE03}"

tail -n  +2 "/mnt/nfs/Node02/Reporting/CorePID.txt" >  "/mnt/nfs/Node02/Reporting/CorePID.txt" 
tail -n  +2 "/mnt/nfs/Node03/Reporting/CorePID.txt" >  "/mnt/nfs/Node03/Reporting/CorePID.txt"

