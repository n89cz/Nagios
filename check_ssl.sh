#!/bin/bash

SRVNAME="$1"

#NAGIOS return values
NAGIOS_OK="0"
NAGIOS_WARNING="1"
NAGIOS_CRITICAL="2"
NAGIOS_UNKNOWN="3"

#NOT_AFTER=$(echo | openssl s_client -servername $SRVNAME -connect $SRVNAME:443 2>/dev/null | openssl x509 -noout -enddate | sed -e 's#notAfter=##')

NOT_AFTER=$(echo | openssl s_client -showcerts -servername pujcimmoto.cz -connect pujcimmoto.cz:443 2>/dev/null | openssl x509 -inform pem -noout -enddate | sed -e 's#notAfter=##')
NOT_AFTER_SEC=`date -d "${NOT_AFTER}" '+%s'`

#expire intervals in seconds
WARNING_SEC="432000"
CRITICAL_SEC="172800"

WRNSEC=$(($NOT_AFTER_SEC - $WARNING_SEC))
CRITSEC=$(($NOT_AFTER_SEC - $CRITICAL_SEC))


#seconds since 1970-01-01 00:00:00 UTC
SECONDS_NOW=`date +%s`


if [ "$SECONDS_NOW" -gt "$CRITSEC" ] ; then
    echo "CRITICAL - Certificate expires very soon! FIX ASAP!"
    exit $NAGIOS_CRITICAL
elif [ "$SECONDS_NOW" -gt "$WRNSEC" ] ; then
    echo "WARNING - Five days to certificate expiration"
    exit $NAGIOS_WARNING
fi

exit $NAGIOS_OK
