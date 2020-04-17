#!/bin/bash
while docker ps |grep "health: starting" > /dev/null; do 
  echo "Waiting on gitlab container startup...";
  sleep 10; 
done

echo "gitlab container running!"
