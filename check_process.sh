#!/bin/bash
#
#

P_CHECK=dockerd

ps cax | grep $P_CHECK > /dev/null

if [ $? -eq 0 ]; then
    echo "$P_CHECK process is running."
    exit 0
else
    echo "$P_CHECK proces not running."
    exit 1
fi
