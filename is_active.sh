#!/bin/bash

#NAGIOS return values
NAGIOS_OK="0"
NAGIOS_WARNING="1"
NAGIOS_CRITICAL="2"
NAGIOS_UNKNOWN="3"

#Name of service to check
SERVICE="$1"

#Required service state
R_STATE="active"

if [ $# -ne 1 ]; then
    echo "wrong usage, service name required"
    exit 3
fi

#Get service current state
C_STATE=`systemctl is-active $SERVICE`

if [ $C_STATE == $R_STATE ];
then
    echo "Service is active"
    exit $NAGIOS_OK
else
    echo "Service not active"
    exit $NAGIOS_CRITICAL
fi
