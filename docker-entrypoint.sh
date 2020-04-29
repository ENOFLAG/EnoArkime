#!/bin/sh

bash ./elasticsearch_init.sh || exit 1
sh ./moloch-capture.sh &
sh ./moloch-viewer.sh &
wait
