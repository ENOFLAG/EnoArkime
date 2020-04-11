#!/bin/sh

bash ./elasticsearch_init.sh || exit 1
./moloch-user.sh &
./moloch-capture.sh

