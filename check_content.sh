#!/bin/bash

#Nagios return codes
# 0 OK
# 1 warning
# 2 critical
# 3 unknow

function usage() {
    echo "Usage: $0 -H https://pujcimmoto.cz -c 20" 1>&2
    exit 1
}

while getopts ":w:c:" o; do
    case "${o}" in
    w)
	WARNING=${OPTARG}
	;;
    c)
	CRITICAL=${OPTARG}
	;;
    *)
	usage
        ;;
    esac
done


#curl https://pujcimmoto.cz/ | grep "Rodinná půjčovna motocyklů"
curl https://pujcimmoto.cz/ | grep "hududu"
FOUND=$?

if [ $FOUND == 0 ]; then
    echo "OK - searched content found"
    exit 0
else
    echo "CRITICAL - searched content not found"
    exit 2
fi