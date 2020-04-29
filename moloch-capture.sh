#!/bin/bash

while :
do
  echo "Starting Moloch capture"
  ./bin/moloch-capture -n docker -R /data/moloch/raw -m
  sleep 5
done
