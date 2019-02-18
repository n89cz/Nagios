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
    rm /tmp/index.html
}

function file_exists () {
if [ ! -f /tmp/pujcimmoto.file ]; then
    echo "$1"
    exit 2
fi
}

echo $DOMAIN > /tmp/testovac

#wget https://pujcimmoto.cz -O /tmp/test.file
wget $DOMAIN -O /tmp/pujcimmoto.file

file_exists "prvni krok - soubor nenalezen"

    if grep -q 'Rodinná půjčovna motocyklů' /tmp/pujcimmoto.file
    then
#	finish
	file_exists
	echo "Hledana odpoved nalezena"
	exit 0
    else
#	finish
	file_exists
	echo "Nenalezena hledana odpoved"
	exit 2
    fi

fi
