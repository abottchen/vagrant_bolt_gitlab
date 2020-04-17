#!/bin/bash
DONE=false
TIMEOUT=300

let "INTERVAL=${TIMEOUT} / 6"
for ((i=1;i<=${INTERVAL} && ! ${DONE};i++)); do
  docker inspect gitlab > /dev/null 2>&1 && docker ps |grep "healthy" > /dev/null 2>&1
  if [ $? -eq 0 ]; then
    DONE=true
  fi
  if ! ${DONE}; then
    echo "Waiting on gitlab container startup...";
    sleep 10;
  fi
done

if ! ${DONE}; then
  echo "Timed out waiting for gitlab container to start!"
  exit 1
else
  echo "gitlab container running!"
fi
