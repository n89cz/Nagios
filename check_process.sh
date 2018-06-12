#!/bin/bash
#
#

P_CHECK=dockerd

ps cax | grep $P_CHECK > /dev/null

if [ $? -eq 0 ]; then
    echo " OK - $P_CHECK process is running."
    exit 0
else
    echo "CRITICAL - $P_CHECK proces not running."
    exit 2
fi
