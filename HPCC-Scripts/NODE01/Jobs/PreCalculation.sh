#! /usr/bin/bash

## Alias: CompEng0001
## Created by: Richard Blair
## SID: 000947441


## This files estimates the Bits of Entropy, Entropy Time, and storage size and number of hashes

function log2 {
	x=0
	for (( y=$1-1 ; $y > 0 ; y >>=  1 )) ; do
		let x=$x+1
	done
	echo $x
}

CONFIG="/mnt/nfs/Release/Cracker.config"
TEMP=$(awk 'NR==3' ${CONFIG})
POS=$(echo ${TEMP} | grep -b -o £ | awk 'BEGIN{ FS=":"}{print$1+1}' | head -c 1)
#echo ${POS}

N=95 # different symbols
L=$((9-${POS})) # length of string

R=$(echo $(( (${N}**${L}))) ) #Permutation/combinations
WR=$(echo ${R} | awk '{ split(" hundred thousand million billion trillion quadrillion quintrillion", v); s=1; while($1>1000) { $1/=1000; s++ }print "~" int($1) " " v[s]}')

# estimated file size with R*hash byte size (32 bytes)
FS=$(( ((${R}*256)/8))) # bits
WFS=$(echo ${FS} | awk '{ split("B KB MB GB TB PB ZB", v); s=1; while($1>1024) { $1/=1024; s++ } print "~"int($1) " " v[s]}')

ENTROPY=$(log2 ${R}) # bits of entropy

EPS=6.750 # ENTRPOY per symbol at N
CORES=$(awk 'NR==4' ${CONFIG})
SCPS=19
IPS=$(( ${CORES}*${SCPS} )) # estimated iterations per second on CORES

#AMADHL=$(echo "scale=2; ${CORES}/${N}*${R}/${R}" | bc )
ESTTIME=$(((2**${ENTROPY}) / ${IPS}))

#echo -e ${AMADHL}
echo -e ""
echo -e "Pre Calculated Statistics"
echo -e ""
echo -e "Note that it is not possible to brute force a 256-bit non-reversable hash with this technology..."
echo -e ""
echo -e "Number of possible symbols: ${N}"
echo -e "Length of Password: ${L}"
echo -e "Number of Possible Password Permutations(R) is ${N}^${L} = ${WR}"
echo -e "Estimated FileSize for a Rainbow Table for all possible R: ${WFS}"
echo -e "Entropy per Symbol at ${N}: ${EPS}"
echo -e "Bits of Entropy is log2(${N}^${L}) = ${ENTROPY/}"
echo -e "Number of Cores to be assigned: ${CORES}"
echo -e "Iterations per core is: ${SCPS}"
echo -e "Total estimated iterations per second is ${CORES}*${SCPS} = ${IPS}"
#echo -e "Amadhl's law speed up is ${AMADHL}%"
echo -ne "Estimated time to Entropy log2(2^${ENTROPY}/${IPS}) is: "
bash /mnt/nfs/Utilities/ConvertFromSeconds.sh ${ESTTIME}

echo -e ""
