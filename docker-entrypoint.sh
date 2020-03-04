#!/bin/sh
sh ./moloch-capture.sh &
sh ./moloch-user.sh &
sh ./moloch-viewer.sh &
wait
