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
    rm index.html
}

wget https://$DOMAIN
#wget https://pujcimmoto.cz

if grep -q 'Rodinná motopůjčovna nabízející nezapomenutelný zážitek v jedné stopě.' index.html
then
    finish
    echo "Hledana odpoved nalezena"
    exit 0
else
    finish
    echo "Nenalezena hledana odpoved"
    exit 2
fi