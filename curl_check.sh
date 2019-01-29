#!/bin/bash
#
#check curl response

#regios codes
STATE_OK="0"
STATE_WARNING="1"
STATE_CRITICAL="2"
STATE_UNKNOWN="3"

CHECK_URL=$1

CURL_OK="200"

#check $1
if [ "$#" -ne 1 ]; then
    echo "wrong script usage - parameter needed"
    exit 3
fi

CURL_OUTPUT=$(curl -s -o /dev/null -w "%{http_code}" $CHECK_URL)

echo $CURL_OUTPUT

if [ "$CURL_OUTPUT" == "$CURL_OK" ] ; then
    echo "OK - WEB is UP"
    exit 0
elif [ "$CURL_OUTPUT" != "$CURL_OK" ] ; then
    echo "CHYBA CURL FAILURE $CURL_OUTPUT"
    exit 2
fi