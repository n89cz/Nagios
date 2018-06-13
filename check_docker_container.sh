#!/bin/bash
#
# Nagios: check_nrpe!check_docker_container!_container_id_
# Usage: ./check_docker_container.sh _container_id_

CONTAINER=$1

if [ $# -ne 1 ]; then
    echo "wrong usage, container name required"
    exit 3
fi

docker info > /dev/null 2>&1
if [ $? -ne 0 ]; then
  echo "UNKNOWN - Is Docker daemon up?"
  exit 3
fi

RUNNING=$(docker inspect --format="{{.State.Running}}" $CONTAINER 2> /dev/null)

if [ $? -eq 1 ]; then
  echo "UNKNOWN - $CONTAINER does not exist."
  exit 3
fi

if [ "$RUNNING" == "false" ]; then
  echo "CRITICAL - $CONTAINER is not running."
  exit 2
fi

RESTARTING=$(docker inspect --format="{{.State.Restarting}}" $CONTAINER)

if [ "$RESTARTING" == "true" ]; then
  echo "WARNING - $CONTAINER state: restarting."
  exit 1
fi

STARTED=$(docker inspect --format="{{.State.StartedAt}}" $CONTAINER)
NETWORK=$(docker inspect --format="{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}" $CONTAINER)

echo "OK - $CONTAINER with IP $NETWORK is up, Started: $STARTED"
