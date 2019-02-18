#!/bin/bash
#
# Nagios script to check text on webpage
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
	echo "Hledana odpoved nalezena"
	exit 0
    else
	file_exists "File not found in step 3"
	finish
	echo "Nenalezena hledana odpoved"
	exit 2
    fi

fi
