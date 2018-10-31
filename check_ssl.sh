#!/bin/bash

SERVERNAME="$1"

# zjistit not after date
# od neho odecist 5 (warning) a 2 (critical)
# vypsat soucasny stav %s (date +%s) a porovnat
# pokud soucasny stav mensi nez warning tak prislusna chyba, pokud soucasny stav mensi ne critical tak chyba, pokud soucasny stav vetsi nez critical i nez warning tak je vse v poradku a do expirace certifikatu zbyva vice nez 5 dni

#NAGIOS return values
NAGIOS_OK="0"
NAGIOS_WARNING="1"
NAGIOS_CRITICAL="2"
NAGIOS_UNKNOWN="3"


NOT_AFTER=$(echo | openssl s_client -servername $SERVERNAME -connect $SERVERNAME:443 2>/dev/null | openssl x509 -noout -enddate | sed -e 's#notAfter=##')
NOT_AFTER_SEC=`date -d "${NOT_AFTER}" '+%s'`

#expire intervals in seconds
WARNING_SEC="432000"
CRITICAL_SEC="172800"

WRNSEC=$(($NOT_AFTER_SEC - $WARNING_SEC))
CRITSEC=$(($NOT_AFTER_SEC - $CRITICAL_SEC))


#seconds since 1970-01-01 00:00:00 UTC
SECONDS_NOW=`date +%s`


if [ "$SECONDS_NOW" -gt "$CRITSEC" ] ; then
    echo "CRITICAL - Two days to certificate expiration"
    exit $NAGIOS_CRITICAL
elif [ "$SECONDS_NOW" -gt "$WRNSEC" ] ; then
    echo "WARNING - Five days to certificate expiration"
    exit $NAGIOS_WARNING
fi



#echo "Not after sec: "$NOT_AFTER_SEC
#echo "Warning sec: " $WRNSEC

exit $NAGIOS_OK
