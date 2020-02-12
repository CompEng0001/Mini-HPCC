#! /usr/bin/bash

## Alias: CompEng0001
## Created by: Richard BLair
## SID: 000947441

NODE=$1
CORE=$2
SPLIT=$3

CONFIG="/mnt/nfs/Release/Cracker.config"
KNOWNSSID=$(awk 'NR==1' ${CONFIG})
KNOWNHASH=$(awk 'NR==2' ${CONFIG})
TEMP=$(awk 'NR==3' ${CONFIG})
KNOWNPASSWORD=$(awk 'NR==3' ${CONFIG} | od -t u1 -An | cut -d ' ' -f1-19 | sed -e 's/^[ \t]*//' | tr -s " " )
LOOPS=$(bash /mnt/nfs/Release/ASCIIStartEnd.sh $2 $3)

STARTLOOP=$(echo ${LOOPS} | awk '{print$1}')
ENDLOOP=$(echo ${LOOPS} | awk '{print$2+1}')

POS=$(echo ${TEMP} | grep -b -o £ | awk 'BEGIN{ FS=":"}{print$1+1}' | head -c 1)

ONE=$(echo -e ${KNOWNPASSWORD} | awk '$1<127 {print $1; next};{print "32"}' )
OONE=${ONE}
EONE=$(echo -e ${KNOWNPASSWORD} | awk '$1<127 {print $1+1; next};{print "127"}')

TWO=$(echo -e ${KNOWNPASSWORD} | awk '$2<127 {print $2; next};{print "32"}' )
OTWO=${TWO}
ETWO=$(echo -e ${KNOWNPASSWORD} | awk '$2<127 {print $2+1; next};{print "127"}')

THREE=$(echo -e ${KNOWNPASSWORD} | awk '$3<127 {print $3; next};{print "32"}' )
OTHREE=${THREE}
ETHREE=$(echo -e ${KNOWNPASSWORD} | awk '$3<127 {print $3+1; next};{print "127"}')

FOUR=$(echo -e ${KNOWNPASSWORD} | awk '$4<127 {print $4; next};{print "32"}' )
OFOUR=${FOUR}
EFOUR=$(echo -e ${KNOWNPASSWORD} | awk '$4<127 {print $4+1; next};{print "127"}')

FIVE=$(echo -e ${KNOWNPASSWORD} | awk '$5<127 {print $5; next};{print "32"}' )
OFIVE=${FIVE}
EFIVE=$(echo -e ${KNOWNPASSWORD} | awk '$5<127 {print $5+1; next};{print "127"}')

SIX=$(echo -e ${KNOWNPASSWORD} | awk '$6<127 {print $6; next};{print "32"}' )
OSIX=${SIX}

ESIX=$(echo -e ${KNOWNPASSWORD} | awk '$6<127 {print $6+1; next};{print "127"}')

SEVEN=$(echo -e ${KNOWNPASSWORD} | awk '$7<127 {print $7; next};{print "32"}' )
OSEVEN=${SEVEN}
ESEVEN=$(echo -e ${KNOWNPASSWORD} | awk '$7<127 {print $7+1; next};{print "127"}')

EIGHT=$(echo -e ${KNOWNPASSWORD} | awk '$8<127 {print $8; next};{print "32"}' )
OEIGHT=${EIGHT}
EEIGHT=$(echo -e ${KNOWNPASSWORD} | awk '$8<127 {print $8+1; next};{print "127"}')

sleep 4

if [[ ${POS} == 1  ]]; then
	ONE=${STARTLOOP}
	EONE=${ENDLOOP}
	LOCKONE=1

elif [[ ${POS} == 2 ]]; then
	TWO=${STARTLOOP}
	ETWO=${ENDLOOP}
	LOCKTWO=1
elif [[ ${POS} == 3 ]]; then
	THREE=${STARTLOOP}
	ETHREE=${ENDLOOP}
	LOCKTHREE=1
elif [[ ${POS} == 4 ]]; then
	FOUR=${STARTLOOP}
	EFOUR=${ENDLOOP}
	LOCKFOUR=1
elif [[ ${POS} == 5 ]]; then
	FIVE=$((${STARTLOOP}+5))
	EFIVE=${ENDLOOP}
	LOCKFIVE=1
elif [[ ${POS} == 6 ]]; then
	SIX=${STARTLOOP}
	ESIX=${ENDLOOP}
	LOCKSIX=1

elif [[ ${POS} == 7 ]]; then
	SEVEN=${STARTLOOP}
	ESEVEN=${ENDLOOP}
	LOCKSEVEN=1
else
	EIGHT=${STARTLOOP}
	EEIGHT=${ENDLOOP}
	LOCKEIGHT=1
fi

START=$(date +%s%3N)
while [ ${ONE} -le ${EONE} ]
do
        GUESSONE=$(echo "${ONE}" | awk '{ printf("%c",$0); }')
        while [ ${TWO} -le ${ETWO} ]
        	do
                GUESSTWO=$(echo "${TWO}" | awk '{ printf("%c",$0); }')

                while [ ${THREE} -le ${ETHREE} ]
                	do
                        GUESSTHREE=$(echo "${THREE}" | awk '{ printf("%c",$0); }') 

                        while [ ${FOUR} -le ${EFOUR} ]
                       		do

                                GUESSFOUR=$(echo "${FOUR}" | awk '{ printf("%c",$0); }')

                                while [ ${FIVE} -le ${EFIVE} ]
                                	do

                                        GUESSFIVE=$(echo "${FIVE}" | awk '{ printf("%c",$0); }')

                                        while [ ${SIX} -le ${ESIX} ]
                                        	do

                                                GUESSSIX=$(echo "${SIX}" | awk '{ printf("%c",$0); }')

                                                while [ ${SEVEN} -le ${ESEVEN} ]
                                                	do

                                                        GUESSSEVEN=$(echo "${SEVEN}" | awk '{ printf("%c",$0); }')

                                                        while [ ${EIGHT} -le ${EEIGHT} ]
	                                                        do
                                                                GUESSEIGHT=$(echo "${EIGHT}" | awk '{ printf("%c",$0); }')
                                                                GUESS=${GUESSONE}${GUESSTWO}${GUESSTHREE}${GUESSFOUR}${GUESSFIVE}${GUESSSIX}${GUESSSEVEN}${GUESSEIGHT} 
																WPAOUTPUT=$(wpa_passphrase ${KNOWNSSID} "${GUESS}")
																GUESSHASH=$(echo ${WPAOUTPUT} | awk -F '=' '{print $NF}' | rev | cut -c 3- | rev)
																ITERATIONS=$((${ITERATIONS} + 1))
                                                                        if [ "${GUESSHASH}" == "${KNOWNHASH}" ];
                                                                       	then
																			END=$(date +%s%3N)
																			DURATION=$(( ${END} - ${START} ))
                                                                            echo -n -e "${GUESS} ${ITERATIONS} ${DURATION} ${NODE} ${CORE}" >> /mnt/nfs/Node0${NODE}/Reporting/Node0${NODE}Completed.txt
                                                                        	exit 0
																		fi
																EIGHT=$(( ${EIGHT}+1 ))
																GUESSHASH=""
																GUESS=""
                                                       		done
														if [[ LOCKEIGHT == 1 ]];then
															EIGHT=${STARTLOOP}
														else
															EIGHT=${OEIGHT}
														fi
						       							SEVEN=$(( ${SEVEN} + 1 ))
                                               		 done
													if [[ LOCKSEVEN == 1 ]];then
														SEVEN=${STARTLOOP}
													else
														SEVEN=${OSEVEN}
													fi
													SIX=$(( ${SIX} + 1 ))
                                        	done
										if [[ LOCKSIX == 1 ]];then
											SIX=${STARTLOOP}
										else
											SIX=${OSIX}
										fi
										FIVE=$(( ${FIVE} + 1 ))
                                	done
								if [[ LOCKFIVE == 1 ]];then
									FIVE=${STARTLOOP}
								else
									FIVE=${OFIVE}
								fi
								FOUR=$(( ${FOUR} + 1 ))
                        	done
							if [[ LOCKFOUR == 1 ]];then
								FOUR=${STARTLOOP}
							else
								FOUR=${OFOUR}
							fi
                        	THREE=$(( ${THREE} + 1 ))
                	done
					if [[ LOCKTHREE == 1 ]];then
						THREE=${STARTLOOP}
					else
						THREE=${OTHREE}
					fi
					TWO=$(( ${TWO} + 1 ))
        	done
		if [[ LOCKTWO == 1 ]];then
			TWO=${STARTLOOP}
		else
			TWO=${OTWO}
		fi
        ONE=$(( ${ONE} + 1 ))
done
