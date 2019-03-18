#!/bin/bash

#DOMAIN=$1
DOMAIN=https://pujcimmoto.cz


#curl limits
CURL_WARN=0.7
CURL_CRIT=2

#Nagios status codes
NAGI_OK="0"
NAGI_WARNING="1"
NAGI_CRITICAL="2"
NAGI_UNKNOWN="3"

RESPONSE=`curl --connect-timeout 15 --max-time 15 -o /dev/null -s -w '%{time_total}' $DOMAIN | tr ',' '.'`

if [[ "$RESPONSE" < "$CURL_WARN" ]]; then
    echo "OK - response time: $RESPONSE s"
    exit 0
elif [[ "$RESPONSE" > "$CURL_WARN" && "$RESPONSE" < $CURL_CRIT ]]; then
    echo "Warning - response time: $RESPONSE s"
    exit 1
elif [[ "$RESPONSE" > "$CURL_CRIT" ]]; then
    echo "Failure - response time: $RESPONSE s"
    exit 2
else
    echo "Unknown status - $RESPONSE"
    exit 3
fi
