#! /usr/bin/bash

## Alias: CompEng0001
## Created By: Richard Blair
## SID: 000947441

CMD="ps -eo args | grep wpa_passphrase | grep -v grep | awk '{print \$3}'"

NODE02=$(ssh -q Node02 "${CMD}")
NODE03=$(ssh -q Node03 "${CMD}")

while [[ -z ${NODE02} ]]
	do
		NODE02=$(ssh Node02 "${CMD}")
	done

while [[ -z ${NODE03} ]]
	do
		NODE03=$(ssh Node03 "${CMD}")
	done
echo "~Real-Time Password(s) Node02: " ${NODE02}
echo "~Real-Time Password(s) Node03: " ${NODE03}
