#!/bin/bash

cd viewer
while :
do
  echo "Starting Moloch viewer"
  ../bin/node ./viewer.js
  sleep 5
done
