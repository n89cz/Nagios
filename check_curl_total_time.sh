#!/bin/bash

DOMAIN=$1

#curl limits
CURL_WARN=0.7
CURL_CRIT=2

#Nagios status codes
NAGI_OK="0"
NAGI_WARNING="1"
NAGI_CRITICAL="2"
NAGI_UNKNOWN="3"

RESPONSE=`curl -o /dev/null -s -w '%{time_total}' $DOMAIN | tr ',' '.'`

if [[ "$RESPONSE" < "$CURL_WARN" ]]; then
    echo "OK - response time: $RESPONSE s"
    exit $NAGI_OK
elif [[ "$RESPONSE" > "$CURL_WARN" && "$RESPONSE" < $CURL_CRIT ]]; then
    echo "Warning - response time: $RESPONSE s"
    exit $NAGI_WARNING
elif [[ "$RESPONSE" > "$CURL_CRIT" ]]; then
    echo "Failure - response time: $RESPONSE s"
    exit $NAGI_CRITICAL
else
    echo "Unknown status - $RESPONSE"
    exit $NAGI_UNKNOWN
fi
