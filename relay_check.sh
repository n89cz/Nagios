#!/bin/bash
#
#

#Nagios return codes
# 0 OK
# 1 warning
# 2 critical
# 3 unknow

#function for trap 
#usage: trap finish exit 1
function finish {
    #do someting
    echo ok
}

if grep -q 'local' /var/log/maillog
then
    echo "local relay found, failure"
    exit 2
else
    echo "no local relay found"
    exit 0
fi