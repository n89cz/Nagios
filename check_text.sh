#!/bin/bash
#
# Nagios script to check text on webpage
#

#TODO:
# 1.
# put searched string to $SEARCHED_STRING and use Nagios to pass the data
#
#
# 2.
# Make tmp file name independant - use for example current datetime as name of the file
#
#
# Make sure the script is universal, only thing you need to change is configuration of Nagios command
#



#Nagios return codes
# 0 OK
# 1 warning
# 2 critical
# 3 unknow

DOMAIN=$1
SEARCHED_STRING=$2

function finish {
    rm /tmp/pujcimmoto.file
}

function file_exists () {
if [ ! -f /tmp/pujcimmoto.file ]; then
    echo "$1"
    exit 3
fi
}

wget $DOMAIN -O /tmp/pujcimmoto.file

file_exists "File not found in step 1"

    if grep -q 'Rodinná půjčovna motocyklů' /tmp/pujcimmoto.file
    then
	file_exists "File not found in step 2"
	finish
	echo "OK - searched string found"
	exit 0
    else
	file_exists "File not found in step 3"
	finish
	echo "Failure - searched string not found"
	exit 2
    fi

fi
