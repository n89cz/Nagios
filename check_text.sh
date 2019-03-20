#!/bin/bash
#
# Nagios script to check text on webpage
# Requires two params. First ($1) is domain name and second ($2) is searched string


# 2.
# Make tmp file name independant - use for example current datetime as name of the file


#Nagios return codes
# 0 OK
# 1 warning
# 2 critical
# 3 unknow

DOMAIN="$1"
SEARCHED_STRING="$2"

echo $DOMAIN
echo $SEARCHED_STRING

C_DATE=`date +%Y%m%d%H%M%S%N`

TMP_FILE="/tmp/$DOMAIN$C_DATE"

function finish {
    rm $TMP_FILE
}

function file_exists () {
if [ ! -f $TMP_FILE ]; then
    echo "$1"
    exit 3
fi
}

wget $DOMAIN -O $TMP_FILE

file_exists "File not found in step 1"

    if grep -q "$SEARCHED_STRING" $TMP_FILE
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
