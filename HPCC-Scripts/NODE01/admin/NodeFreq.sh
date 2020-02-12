#! /usr/bin/bash

## Alias: CompEng0001
## Created by: Richard Blair
## SID: 000947441


# change the operating freq of nodes update min and max to be the same to ensure true speed. 
FREQ=$1
CPU0="/sys/devices/system/cpu/cpu0/cpufreq/"
CPU1="/sys/devices/system/cpu/cpu1/cpufreq/"
CPU2="/sys/devices/system/cpu/cpu2/cpufreq/"
CPU3="/sys/devices/system/cpu/cpu3/cpufreq/"
MAX="scaling_max_freq"
MIN="scaling_min_freq"

STATUSNODE02=$(ssh Node02 "sudo echo -e ${FREQ} > ${CPU0}${MAX} && sudo echo -e ${FREQ} > ${CPU0}${MIN} && sudo echo -e ${FREQ} > ${CPU1}${MAX} && sudo echo -e ${FREQ} > ${CPU1}${MIN} && sudo echo -e ${FREQ} > ${CPU2}${MAX} && sudo echo -e ${FREQ} > ${CPU2}${MIN} && sudo echo -e ${FREQ} > ${CPU3}${MAX} && sudo echo -e ${FREQ} > ${CPU3}${MIN}")

STATUSNODE03=$(ssh Node03 "sudo echo -e ${FREQ} > ${CPU0}${MAX} && sudo echo -e ${FREQ} > ${CPU0}${MIN} && sudo echo -e ${FREQ} > ${CPU1}${MAX} && sudo echo -e ${FREQ} > ${CPU1}${MIN} && sudo echo -e ${FREQ} > ${CPU2}${MAX} && sudo echo -e ${FREQ} > ${CPU2}${MIN} && sudo echo -e ${FREQ} > ${CPU3}${MAX} && sudo echo -e ${FREQ} > ${CPU3}${MIN}")
