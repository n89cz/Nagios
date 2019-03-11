#!/bin/bash

#DOMAIN=$1
DOMAIN="https://domain.name"

#
WARN=0.7

#Nagios status codes
STATE_OK="0"
STATE_WARNING="1"
STATE_CRITICAL="2"
STATE_UNKNOWN="3"

#RESPONSE=`curl -o /dev/null -s -w '%{time_total}' $DOMAIN`

RESPONSE=`curl -o /dev/null -s -w '%{time_total}' $DOMAIN | tr ',' '.'`

if [[ "$RESPONSE" < "$WARN" ]]; then
    echo "AOK"
else
    echo "nenene"
fi

#echo $RESPONSE | tr ',' '.'

echo $RESPONSE
