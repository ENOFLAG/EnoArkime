#!/bin/bash

cd viewer
while :
do
  echo "Starting Moloch viewer"
  ../bin/node ./viewer.js -n docker
  sleep 5
done
