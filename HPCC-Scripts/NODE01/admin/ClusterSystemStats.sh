#! /usr/bin/expect -f

## Alias: CompEng0001
## Created by: Richard Blair
## SID: 000947441


SYSTEMSTATSNODE01=$(hostname && cat /sys/devices/system/cpu/present && cat /sys/devices/system/cpu/cpufreq/policy0/scaling_cur_freq && cat /sys/devices/system/cpu/cpufreq/policy0/scaling_min_freq && cat /sys/devices/system/cpu/cpufreq/policy0/scaling_max_freq && vcgencmd measure_temp)
SYSTEMSTATSNODE02=$(ssh -q Node02 "sudo hostname && cat /sys/devices/system/cpu/present && cat /sys/devices/system/cpu/cpufreq/policy0/scaling_cur_freq && cat /sys/devices/system/cpu/cpufreq/policy0/scaling_min_freq && cat /sys/devices/system/cpu/cpufreq/policy0/scaling_max_freq && vcgencmd measure_temp")
SYSTEMSTATSNODE03=$(ssh -q Node03 "sudo hostname && cat /sys/devices/system/cpu/present && cat /sys/devices/system/cpu/cpufreq/policy0/scaling_cur_freq && cat /sys/devices/system/cpu/cpufreq/policy0/scaling_min_freq && cat /sys/devices/system/cpu/cpufreq/policy0/scaling_max_freq && vcgencmd measure_temp ")


echo -e ""
echo -e "Rubus Thicket System Stats"
echo -e ${SYSTEMSTATSNODE01} | awk -v OFS='\t' 'BEGIN { printf "%s\t%s\t%s\t%s\t%s\t%s\n", "Host", "CPU(s)", "CurMHz", "MinMHz","MaxMHz", "Temperature"} {print $1,$2,$3,$4,$5,$6}' 
echo -e ${SYSTEMSTATSNODE02} | awk -v OFS='\t' 'BEGIN { printf ""} {print $1,$2,$3,$4,$5,$6}'
echo -e ${SYSTEMSTATSNODE03} | awk -v OFS='\t' 'BEGIN { printf ""} {print $1,$2,$3,$4,$5,$6}'
echo -e ""


